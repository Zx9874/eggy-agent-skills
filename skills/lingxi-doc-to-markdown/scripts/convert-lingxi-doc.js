#!/usr/bin/env node
'use strict';

const { spawn } = require('child_process');
const crypto = require('crypto');
const fs = require('fs');
const os = require('os');
const path = require('path');

const TOOL_NAME = '灵犀公开文档转 Markdown';
const DOCS_HOST = 'docs.popo.netease.com';
const OFFICE_HOST = 'office.netease.com';
const DEFAULT_TIMEOUT_MS = 90_000;
const DEFAULT_IMAGE_TIMEOUT_MS = 30_000;
const DEFAULT_CONCURRENCY = 4;
const MAX_IMAGE_BYTES = 200 * 1024 * 1024;
const USER_AGENT =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36';

class ConversionError extends Error {
  constructor(message, code = 'CONVERSION_FAILED') {
    super(message);
    this.name = 'ConversionError';
    this.code = code;
  }
}

const delay = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));

function printHelp() {
  console.log(`${TOOL_NAME}

用法：
  node convert-lingxi-doc.js --url <灵犀分享网址> [选项]

必选参数：
  --url <网址>                    公开可读的灵犀文档分享网址

输出参数：
  --output <文件.md>              指定输出文件；省略时按文档标题写入当前目录
  --overwrite                     允许原子替换已有文档与同名 .assets 目录
  --allow-remote-images           个别图片失败时保留远程地址；默认失败即不替换输出

运行参数：
  --chrome <浏览器路径>           指定 Chrome 或 Chromium 可执行文件
  --timeout-seconds <秒>          等待完整正文的时间，默认 90
  --image-timeout-seconds <秒>    每次图片请求的时间，默认 30
  --concurrency <1-8>             图片并发数，默认 4
  --help                          显示本帮助

示例：
  node convert-lingxi-doc.js --url "https://docs.popo.netease.com/lingxi/<文档编号>"
  node convert-lingxi-doc.js --url "<分享网址>" --output "资料来源/文档.md" --overwrite

说明：
  仅处理页面本身允许公开访客读取的灵犀文本文档。程序不会打印或保存访客 Cookie、访问令牌和一次性正文网址。`);
}

function parsePositiveNumber(value, name, minimum, maximum) {
  const number = Number(value);
  if (!Number.isFinite(number) || number < minimum || number > maximum) {
    throw new ConversionError(`${name} 必须在 ${minimum} 到 ${maximum} 之间`, 'INVALID_ARGUMENT');
  }
  return number;
}

function parseArguments(argv) {
  const options = {
    url: '',
    output: '',
    overwrite: false,
    allowRemoteImages: false,
    chrome: '',
    timeoutMs: DEFAULT_TIMEOUT_MS,
    imageTimeoutMs: DEFAULT_IMAGE_TIMEOUT_MS,
    concurrency: DEFAULT_CONCURRENCY,
    help: false,
  };

  for (let index = 0; index < argv.length; index += 1) {
    const argument = argv[index];
    const nextValue = () => {
      index += 1;
      if (index >= argv.length || argv[index].startsWith('--')) {
        throw new ConversionError(`${argument} 缺少参数值`, 'INVALID_ARGUMENT');
      }
      return argv[index];
    };

    if (argument === '--url') options.url = nextValue();
    else if (argument === '--output') options.output = nextValue();
    else if (argument === '--chrome') options.chrome = nextValue();
    else if (argument === '--overwrite') options.overwrite = true;
    else if (argument === '--allow-remote-images') options.allowRemoteImages = true;
    else if (argument === '--timeout-seconds') {
      options.timeoutMs =
        parsePositiveNumber(nextValue(), '--timeout-seconds', 10, 600) * 1000;
    } else if (argument === '--image-timeout-seconds') {
      options.imageTimeoutMs =
        parsePositiveNumber(nextValue(), '--image-timeout-seconds', 5, 180) * 1000;
    } else if (argument === '--concurrency') {
      options.concurrency = parsePositiveNumber(nextValue(), '--concurrency', 1, 8);
    } else if (argument === '--help' || argument === '-h') options.help = true;
    else throw new ConversionError(`未知参数：${argument}`, 'INVALID_ARGUMENT');
  }

  if (!options.help && !options.url) {
    throw new ConversionError('缺少 --url 参数', 'INVALID_ARGUMENT');
  }
  return options;
}

function parseSourceUrl(input) {
  let source;
  try {
    source = new URL(input);
  } catch {
    throw new ConversionError('灵犀分享网址格式无效', 'INVALID_URL');
  }

  if (source.protocol !== 'https:' || source.hostname.toLowerCase() !== DOCS_HOST) {
    throw new ConversionError(
      `只接受 https://${DOCS_HOST}/lingxi/ 下的公开分享网址`,
      'INVALID_URL',
    );
  }

  const match = /^\/lingxi\/([^/]+)\/?$/.exec(source.pathname);
  if (!match) {
    throw new ConversionError('网址路径中没有有效的灵犀文档编号', 'INVALID_URL');
  }

  let documentId;
  try {
    documentId = decodeURIComponent(match[1]);
  } catch {
    throw new ConversionError('文档编号编码无效', 'INVALID_URL');
  }
  if (!/^[A-Za-z0-9_-]{8,128}$/.test(documentId)) {
    throw new ConversionError('文档编号包含不支持的字符', 'INVALID_URL');
  }

  return { source, documentId };
}

function safeBusinessMessage(data, fallback) {
  const value = data?.message ?? data?.msg ?? data?.errorMessage;
  return typeof value === 'string' && value.trim() ? value.trim() : fallback;
}

function splitCombinedSetCookie(value) {
  if (!value) return [];
  return value.split(/,(?=\s*[^;,=\s]+=[^;,]*)/g);
}

class SimpleCookieJar {
  constructor() {
    this.values = new Map();
  }

  absorb(response) {
    let cookies = [];
    if (typeof response.headers.getSetCookie === 'function') {
      cookies = response.headers.getSetCookie();
    } else {
      cookies = splitCombinedSetCookie(response.headers.get('set-cookie'));
    }

    for (const cookie of cookies) {
      const firstPart = String(cookie).split(';', 1)[0];
      const separator = firstPart.indexOf('=');
      if (separator <= 0) continue;
      const name = firstPart.slice(0, separator).trim();
      const value = firstPart.slice(separator + 1).trim();
      if (!name) continue;
      if (value) this.values.set(name, value);
      else this.values.delete(name);
    }
  }

  header() {
    return [...this.values.entries()].map(([name, value]) => `${name}=${value}`).join('; ');
  }

  get(name) {
    return this.values.get(name) || '';
  }
}

async function fetchWithTimeout(url, options, timeoutMs) {
  return fetch(url, { ...options, signal: AbortSignal.timeout(timeoutMs) });
}

async function fetchJson(url, options, timeoutMs, cookieJar) {
  const headers = new Headers(options.headers || {});
  const cookieHeader = cookieJar?.header();
  if (cookieHeader && !headers.has('Cookie')) headers.set('Cookie', cookieHeader);

  const response = await fetchWithTimeout(
    url,
    { ...options, headers, redirect: options.redirect || 'manual' },
    timeoutMs,
  );
  cookieJar?.absorb(response);

  let data;
  try {
    data = await response.json();
  } catch {
    throw new ConversionError(
      `接口没有返回有效结构化数据（传输状态 ${response.status}）`,
      'INVALID_RESPONSE',
    );
  }
  if (!response.ok) {
    throw new ConversionError(
      `接口请求失败（传输状态 ${response.status}）：${safeBusinessMessage(data, '未知错误')}`,
      'REQUEST_FAILED',
    );
  }
  return data;
}

function createTraceparent() {
  return `00-${crypto.randomBytes(16).toString('hex')}-${crypto
    .randomBytes(8)
    .toString('hex')}-01`;
}

async function createOfficeEntry(source, documentId, timeoutMs) {
  const cookieJar = new SimpleCookieJar();
  const commonHeaders = {
    Accept: 'application/json, text/plain, */*',
    Origin: `https://${DOCS_HOST}`,
    Referer: source.toString(),
    'User-Agent': USER_AGENT,
  };

  console.error('[1/5] 建立公开访客会话');
  try {
    const landingResponse = await fetchWithTimeout(
      source,
      { headers: { 'User-Agent': USER_AGENT }, redirect: 'follow' },
      timeoutMs,
    );
    cookieJar.absorb(landingResponse);
    if (!landingResponse.ok) {
      throw new ConversionError(
        `分享页面无法打开（传输状态 ${landingResponse.status}）`,
        'PAGE_UNAVAILABLE',
      );
    }
  } catch (error) {
    if (error instanceof ConversionError) throw error;
    throw new ConversionError(`分享页面无法打开：${error.message}`, 'PAGE_UNAVAILABLE');
  }

  const accessUrl = `https://${DOCS_HOST}/api/bs-doc/v1/access/url`;
  const access = await fetchJson(
    accessUrl,
    {
      method: 'POST',
      headers: { ...commonHeaders, 'Content-Type': 'application/json;charset=UTF-8' },
      body: JSON.stringify({ itemType: 0, itemId: documentId }),
    },
    timeoutMs,
    cookieJar,
  );

  if (Number(access?.status) !== 1 || Number(access?.data?.canAccess) !== 1) {
    throw new ConversionError(
      `该分享链接不允许公开访客读取：${safeBusinessMessage(access, '访问检查未通过')}`,
      'ACCESS_DENIED',
    );
  }

  const additional = new URLSearchParams();
  for (const [name, value] of source.searchParams.entries()) {
    if (!['identity', 'docType', 'defaultTheme', 'from', 'traceparent', 'fragment'].includes(name)) {
      additional.append(name, value);
    }
  }
  additional.set('identity', documentId);
  additional.set('docType', '1');
  additional.set('defaultTheme', 'light');
  additional.set('from', 'POPO_DOC');
  additional.set('traceparent', createTraceparent());
  if (source.hash) additional.set('fragment', source.hash.slice(1));

  const loginUrl = new URL(`https://${DOCS_HOST}/api/bs-user/v1/disposable/login/third`);
  loginUrl.searchParams.set('type', 'lingxi_doc');
  loginUrl.searchParams.set('additionalParam', additional.toString());

  const loginHeaders = { ...commonHeaders };
  const accessToken = cookieJar.get('accessToken');
  if (accessToken) loginHeaders.Authorization = accessToken;

  const login = await fetchJson(
    loginUrl,
    { method: 'GET', headers: loginHeaders },
    timeoutMs,
    cookieJar,
  );
  if (Number(login?.status) !== 1 || typeof login?.data?.url !== 'string') {
    throw new ConversionError(
      `无法取得正文访客入口：${safeBusinessMessage(login, '响应缺少入口网址')}`,
      'ENTRY_FAILED',
    );
  }

  let officeUrl;
  try {
    officeUrl = new URL(login.data.url);
  } catch {
    throw new ConversionError('正文访客入口格式无效', 'ENTRY_FAILED');
  }
  if (!isOfficeHost(officeUrl.hostname)) {
    throw new ConversionError('正文入口没有指向受信任的网易正文域', 'ENTRY_FAILED');
  }

  officeUrl.searchParams.set('header', 'false');
  officeUrl.searchParams.set('popo_locale', 'zh-CN');
  officeUrl.searchParams.set('docType', '1');
  if (source.hash) officeUrl.hash = source.hash;

  return officeUrl.toString();
}

function isOfficeHost(hostname) {
  const normalized = String(hostname || '').toLowerCase();
  return normalized === OFFICE_HOST || normalized.endsWith(`.${OFFICE_HOST}`);
}

function resolveChrome(requestedPath) {
  const requested = requestedPath || process.env.CHROME_PATH || '';
  if (requested) {
    if (path.isAbsolute(requested) && !fs.existsSync(requested)) {
      throw new ConversionError(`找不到指定浏览器：${requested}`, 'CHROME_NOT_FOUND');
    }
    return requested;
  }

  const candidates = [];
  if (process.platform === 'win32') {
    if (process.env.PROGRAMFILES) {
      candidates.push(path.join(process.env.PROGRAMFILES, 'Google', 'Chrome', 'Application', 'chrome.exe'));
      candidates.push(path.join(process.env.PROGRAMFILES, 'Chromium', 'Application', 'chrome.exe'));
    }
    if (process.env['PROGRAMFILES(X86)']) {
      candidates.push(
        path.join(process.env['PROGRAMFILES(X86)'], 'Google', 'Chrome', 'Application', 'chrome.exe'),
      );
    }
    if (process.env.LOCALAPPDATA) {
      candidates.push(
        path.join(process.env.LOCALAPPDATA, 'Google', 'Chrome', 'Application', 'chrome.exe'),
      );
    }
  } else if (process.platform === 'darwin') {
    candidates.push('/Applications/Google Chrome.app/Contents/MacOS/Google Chrome');
    candidates.push('/Applications/Chromium.app/Contents/MacOS/Chromium');
  } else {
    for (const command of ['google-chrome', 'chromium', 'chromium-browser']) {
      candidates.push(command);
    }
  }

  const absoluteCandidate = candidates.find((candidate) => path.isAbsolute(candidate) && fs.existsSync(candidate));
  if (absoluteCandidate) return absoluteCandidate;
  const commandCandidate = candidates.find((candidate) => !path.isAbsolute(candidate));
  if (commandCandidate) return commandCandidate;

  throw new ConversionError(
    '没有找到 Chrome 或 Chromium；请用 --chrome 指定浏览器可执行文件',
    'CHROME_NOT_FOUND',
  );
}

async function removeDirectoryWithRetry(directory) {
  for (let attempt = 0; attempt < 6; attempt += 1) {
    try {
      fs.rmSync(directory, { recursive: true, force: true });
      return;
    } catch {
      await delay(250 * (attempt + 1));
    }
  }
}

async function launchChrome(chromePath, timeoutMs) {
  if (typeof WebSocket !== 'function') {
    throw new ConversionError(
      '当前 Node.js 没有内置 WebSocket 支持，请使用 Node.js 22 或更高版本',
      'NODE_TOO_OLD',
    );
  }

  const profile = fs.mkdtempSync(path.join(os.tmpdir(), 'lingxi-markdown-'));
  const child = spawn(
    chromePath,
    [
      '--headless=new',
      '--disable-gpu',
      '--no-first-run',
      '--no-default-browser-check',
      '--disable-background-networking',
      '--disable-component-update',
      '--remote-debugging-port=0',
      `--user-data-dir=${profile}`,
      'about:blank',
    ],
    { stdio: 'ignore', windowsHide: true },
  );

  let spawnError = null;
  child.once('error', (error) => {
    spawnError = error;
  });

  const deadline = Date.now() + Math.min(timeoutMs, 30_000);
  const portFile = path.join(profile, 'DevToolsActivePort');
  let port = 0;
  while (Date.now() < deadline) {
    if (spawnError) {
      await removeDirectoryWithRetry(profile);
      throw new ConversionError(`浏览器启动失败：${spawnError.message}`, 'CHROME_START_FAILED');
    }
    if (child.exitCode !== null) {
      await removeDirectoryWithRetry(profile);
      throw new ConversionError(
        `浏览器在调试端口就绪前退出（退出码 ${child.exitCode}）`,
        'CHROME_START_FAILED',
      );
    }
    try {
      const firstLine = fs.readFileSync(portFile, 'utf8').split(/\r?\n/, 1)[0];
      port = Number(firstLine);
      if (Number.isInteger(port) && port > 0) break;
    } catch {}
    await delay(150);
  }
  if (!port) {
    try {
      child.kill();
    } catch {}
    await removeDirectoryWithRetry(profile);
    throw new ConversionError('等待浏览器调试端口超时', 'CHROME_START_FAILED');
  }

  let target = null;
  const targetDeadline = Date.now() + 15_000;
  while (Date.now() < targetDeadline && !target) {
    try {
      const response = await fetch(`http://127.0.0.1:${port}/json/list`, {
        signal: AbortSignal.timeout(2_000),
      });
      const targets = await response.json();
      target = targets.find((item) => item.type === 'page' && item.webSocketDebuggerUrl);
    } catch {}
    if (!target) await delay(150);
  }
  if (!target) {
    try {
      child.kill();
    } catch {}
    await removeDirectoryWithRetry(profile);
    throw new ConversionError('没有找到浏览器页面调试目标', 'CHROME_START_FAILED');
  }

  return {
    child,
    profile,
    webSocketDebuggerUrl: target.webSocketDebuggerUrl,
    async cleanup() {
      try {
        child.kill();
      } catch {}
      const waitDeadline = Date.now() + 2_000;
      while (child.exitCode === null && Date.now() < waitDeadline) await delay(100);
      try {
        if (child.exitCode === null) child.kill('SIGKILL');
      } catch {}
      await removeDirectoryWithRetry(profile);
    },
  };
}

function isDocumentRoot(value) {
  return Boolean(
    value &&
      typeof value === 'object' &&
      !Array.isArray(value) &&
      Array.isArray(value.leaves) &&
      Object.prototype.hasOwnProperty.call(value, 'title') &&
      (Object.prototype.hasOwnProperty.call(value, 'id') ||
        Object.prototype.hasOwnProperty.call(value, 'type')),
  );
}

function findDocumentRoot(value, depth = 0, seen = new Set()) {
  if (!value || typeof value !== 'object' || depth > 8 || seen.has(value)) return null;
  if (isDocumentRoot(value)) return value;
  seen.add(value);

  const preferredKeys = ['data', 'snapshot', 'doc', 'document', 'result', 'content'];
  for (const key of preferredKeys) {
    if (Object.prototype.hasOwnProperty.call(value, key)) {
      const found = findDocumentRoot(value[key], depth + 1, seen);
      if (found) return found;
    }
  }
  return null;
}

function parseSnapshotPayload(payload) {
  let value;
  try {
    value = JSON.parse(payload);
  } catch {
    return null;
  }
  for (let attempt = 0; attempt < 2 && typeof value === 'string'; attempt += 1) {
    try {
      value = JSON.parse(value);
    } catch {
      break;
    }
  }
  const document = findDocumentRoot(value);
  return document ? { document, parsed: value } : null;
}

async function openCdp(webSocketDebuggerUrl) {
  const socket = new WebSocket(webSocketDebuggerUrl);
  await new Promise((resolve, reject) => {
    socket.onopen = resolve;
    socket.onerror = () => reject(new ConversionError('无法连接浏览器调试协议', 'CDP_FAILED'));
  });

  let sequence = 0;
  const pending = new Map();
  const eventListeners = new Set();

  socket.onmessage = (event) => {
    let message;
    try {
      message = JSON.parse(String(event.data));
    } catch {
      return;
    }
    if (message.id) {
      const task = pending.get(message.id);
      if (!task) return;
      pending.delete(message.id);
      if (message.error) task.reject(new ConversionError(message.error.message, 'CDP_FAILED'));
      else task.resolve(message.result || {});
      return;
    }
    for (const listener of eventListeners) listener(message);
  };

  socket.onclose = () => {
    for (const task of pending.values()) {
      task.reject(new ConversionError('浏览器调试连接已关闭', 'CDP_FAILED'));
    }
    pending.clear();
  };

  return {
    socket,
    send(method, params = {}) {
      return new Promise((resolve, reject) => {
        const id = ++sequence;
        pending.set(id, { resolve, reject });
        socket.send(JSON.stringify({ id, method, params }));
      });
    },
    onEvent(listener) {
      eventListeners.add(listener);
      return () => eventListeners.delete(listener);
    },
    close() {
      try {
        socket.close();
      } catch {}
    },
  };
}

async function waitForPromise(promise, timeoutMs, message, code) {
  let timer;
  try {
    return await Promise.race([
      promise,
      new Promise((_, reject) => {
        timer = setTimeout(() => reject(new ConversionError(message, code)), timeoutMs);
      }),
    ]);
  } finally {
    clearTimeout(timer);
  }
}

async function captureDocument(browser, officeUrl, sourceUrl, timeoutMs) {
  console.error('[2/5] 等待实时结构化正文');
  const cdp = await openCdp(browser.webSocketDebuggerUrl);
  let resolveSnapshot;
  const snapshotPromise = new Promise((resolve) => {
    resolveSnapshot = resolve;
  });
  let settled = false;

  const unsubscribe = cdp.onEvent((message) => {
    if (settled || message.method !== 'Network.webSocketFrameReceived') return;
    const frame = message.params?.response;
    if (!frame || Number(frame.opcode) !== 1 || typeof frame.payloadData !== 'string') return;
    const snapshot = parseSnapshotPayload(frame.payloadData);
    if (!snapshot) return;
    settled = true;
    resolveSnapshot({
      document: snapshot.document,
      payloadChars: frame.payloadData.length,
      payloadBytes: Buffer.byteLength(frame.payloadData, 'utf8'),
    });
  });

  try {
    await cdp.send('Network.enable', {
      maxTotalBufferSize: 250_000_000,
      maxResourceBufferSize: 150_000_000,
    });
    await cdp.send('Page.enable');
    await cdp.send('Runtime.enable');
    const navigation = await cdp.send('Page.navigate', { url: officeUrl, referrer: sourceUrl });
    if (navigation.errorText) {
      throw new ConversionError(`正文页面导航失败：${navigation.errorText}`, 'NAVIGATION_FAILED');
    }

    const snapshot = await waitForPromise(
      snapshotPromise,
      timeoutMs,
      '等待完整实时正文超时',
      'SNAPSHOT_TIMEOUT',
    );

    let cookieResult;
    try {
      cookieResult = await cdp.send('Network.getAllCookies');
    } catch {
      cookieResult = await cdp.send('Storage.getCookies');
    }
    const officeCookies = (cookieResult.cookies || []).filter((cookie) => {
      const domain = String(cookie.domain || '').replace(/^\./, '').toLowerCase();
      return domain === OFFICE_HOST || OFFICE_HOST.endsWith(`.${domain}`);
    });
    const officeCookieHeader = officeCookies
      .map((cookie) => `${cookie.name}=${cookie.value}`)
      .join('; ');

    return { ...snapshot, officeCookieHeader };
  } finally {
    unsubscribe();
    cdp.close();
  }
}

function walkLeaves(value, visitor) {
  if (!value) return;
  if (Array.isArray(value)) {
    for (const item of value) walkLeaves(item, visitor);
    return;
  }
  if (typeof value !== 'object') return;
  visitor(value);
  if (Array.isArray(value.leaves)) walkLeaves(value.leaves, visitor);
}

function imageUrlForNode(node) {
  const value = node?.data?.url ?? node?.data?.src;
  return typeof value === 'string' && value.trim() ? value.trim() : '';
}

function analyzeDocument(document) {
  const statistics = {
    topLevelLeaves: document.leaves.length,
    textCharacters: 0,
    headings: 0,
    paragraphs: 0,
    listItems: 0,
    tables: 0,
    quotes: 0,
    horizontalRules: 0,
    imageNodes: 0,
    inlineImages: 0,
    blockImages: 0,
  };
  const imageUrls = [];
  const seenImages = new Set();
  const unknownBlockNames = new Set();
  const knownBlocks = new Set(['table', 'quote', 'image', 'hr']);

  walkLeaves(document.leaves, (node) => {
    if (typeof node.text === 'string') statistics.textCharacters += node.text.length;
    if (node.type === 'split-block') {
      if (node.name === 'heading') statistics.headings += 1;
      else if (node.name === 'paragraph') statistics.paragraphs += 1;
      else if (node.name === 'list-item') statistics.listItems += 1;
    }
    if (node.type === 'block') {
      if (node.name === 'table') statistics.tables += 1;
      else if (node.name === 'quote') statistics.quotes += 1;
      else if (node.name === 'hr') statistics.horizontalRules += 1;
      else if (node.name === 'image') statistics.blockImages += 1;
      else if (node.name && !knownBlocks.has(node.name)) unknownBlockNames.add(node.name);
    }
    if (node.type === 'inline' && node.name === 'image') statistics.inlineImages += 1;

    if (node.name === 'image') {
      const url = imageUrlForNode(node);
      if (url) {
        statistics.imageNodes += 1;
        if (!seenImages.has(url)) {
          seenImages.add(url);
          imageUrls.push(url);
        }
      }
    }
  });

  return { statistics, imageUrls, unknownBlockNames: [...unknownBlockNames].sort() };
}

function sanitizeOutputBaseName(title, documentId) {
  const fallback = `灵犀文档-${documentId}`;
  const cleaned = String(title || fallback)
    .replace(/[<>:"/\\|?*\x00-\x1F]/g, '-')
    .replace(/\s+/g, ' ')
    .replace(/[. ]+$/g, '')
    .trim();
  return (cleaned || fallback).slice(0, 120);
}

function resolveOutputPaths(requestedOutput, document, documentId) {
  let outputPath;
  if (requestedOutput) {
    outputPath = path.resolve(requestedOutput);
    if (path.extname(outputPath).toLowerCase() !== '.md') outputPath += '.md';
  } else {
    const baseName = sanitizeOutputBaseName(document.title, documentId);
    outputPath = path.join(process.cwd(), `${baseName}.md`);
  }
  const baseName = path.basename(outputPath, path.extname(outputPath));
  return {
    outputPath,
    outputDirectory: path.dirname(outputPath),
    assetsBaseName: `${baseName}.assets`,
    assetsPath: path.join(path.dirname(outputPath), `${baseName}.assets`),
  };
}

function detectImageType(buffer, contentType = '') {
  if (buffer.length >= 8 && buffer.subarray(0, 8).toString('hex') === '89504e470d0a1a0a') {
    return { extension: '.png', mediaType: 'image/png' };
  }
  if (buffer.length >= 3 && buffer[0] === 0xff && buffer[1] === 0xd8 && buffer[2] === 0xff) {
    return { extension: '.jpg', mediaType: 'image/jpeg' };
  }
  if (
    buffer.length >= 12 &&
    buffer.subarray(0, 4).toString('ascii') === 'RIFF' &&
    buffer.subarray(8, 12).toString('ascii') === 'WEBP'
  ) {
    return { extension: '.webp', mediaType: 'image/webp' };
  }
  if (buffer.length >= 6 && /^GIF8[79]a$/.test(buffer.subarray(0, 6).toString('ascii'))) {
    return { extension: '.gif', mediaType: 'image/gif' };
  }
  if (
    buffer.length >= 12 &&
    buffer.subarray(4, 12).toString('ascii').startsWith('ftyp') &&
    /avif|avis/.test(buffer.subarray(8, 32).toString('ascii'))
  ) {
    return { extension: '.avif', mediaType: 'image/avif' };
  }
  const prefix = buffer.subarray(0, Math.min(buffer.length, 2048)).toString('utf8').trimStart();
  if (/^<\?xml[\s\S]*?<svg\b/i.test(prefix) || /^<svg\b/i.test(prefix)) {
    return { extension: '.svg', mediaType: 'image/svg+xml' };
  }
  return null;
}

function decodeDataImage(url) {
  const match = /^data:([^;,]+)?(;base64)?,([\s\S]*)$/i.exec(url);
  if (!match) throw new ConversionError('图片数据网址格式无效', 'IMAGE_INVALID');
  const mediaType = String(match[1] || '').toLowerCase();
  if (!mediaType.startsWith('image/')) {
    throw new ConversionError('数据网址不是图片', 'IMAGE_INVALID');
  }
  try {
    return match[2]
      ? Buffer.from(match[3], 'base64')
      : Buffer.from(decodeURIComponent(match[3]), 'utf8');
  } catch {
    throw new ConversionError('图片数据网址无法解码', 'IMAGE_INVALID');
  }
}

async function fetchImageBuffer(sourceUrl, cookieHeader, timeoutMs) {
  if (sourceUrl.startsWith('data:')) {
    const buffer = decodeDataImage(sourceUrl);
    return { buffer, contentType: sourceUrl.slice(5, sourceUrl.indexOf(';')) };
  }

  let currentUrl;
  try {
    currentUrl = new URL(sourceUrl, `https://${OFFICE_HOST}/`);
  } catch {
    throw new ConversionError('图片网址格式无效', 'IMAGE_INVALID');
  }
  if (!['https:', 'http:'].includes(currentUrl.protocol)) {
    throw new ConversionError('图片网址使用了不支持的协议', 'IMAGE_INVALID');
  }

  for (let redirectCount = 0; redirectCount <= 6; redirectCount += 1) {
    const headers = {
      Accept: 'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
      Referer: `https://${OFFICE_HOST}/doc-editor/`,
      'User-Agent': USER_AGENT,
    };
    if (cookieHeader && isOfficeHost(currentUrl.hostname)) headers.Cookie = cookieHeader;

    const response = await fetchWithTimeout(
      currentUrl,
      { headers, redirect: 'manual' },
      timeoutMs,
    );
    if (response.status >= 300 && response.status < 400) {
      const location = response.headers.get('location');
      if (!location) {
        throw new ConversionError(`图片重定向缺少目标地址（${response.status}）`, 'IMAGE_FAILED');
      }
      currentUrl = new URL(location, currentUrl);
      continue;
    }
    if (!response.ok) {
      throw new ConversionError(`图片请求失败（传输状态 ${response.status}）`, 'IMAGE_FAILED');
    }

    const declaredLength = Number(response.headers.get('content-length'));
    if (Number.isFinite(declaredLength) && declaredLength > MAX_IMAGE_BYTES) {
      throw new ConversionError('单张图片超过 200 兆字节安全上限', 'IMAGE_TOO_LARGE');
    }
    const buffer = Buffer.from(await response.arrayBuffer());
    if (buffer.length > MAX_IMAGE_BYTES) {
      throw new ConversionError('单张图片超过 200 兆字节安全上限', 'IMAGE_TOO_LARGE');
    }
    return { buffer, contentType: response.headers.get('content-type') || '' };
  }
  throw new ConversionError('图片重定向次数过多', 'IMAGE_FAILED');
}

function formatMarkdownDestination(destination) {
  const normalized = String(destination).replace(/\\/g, '/');
  if (/[\s()<>]/.test(normalized)) return `<${normalized.replace(/>/g, '%3E')}>`;
  return normalized;
}

async function downloadImages(
  imageUrls,
  stageAssetsPath,
  assetsBaseName,
  cookieHeader,
  options,
) {
  if (!imageUrls.length) {
    return { imageMap: new Map(), results: [], failed: [] };
  }
  fs.mkdirSync(stageAssetsPath, { recursive: true });
  const imageMap = new Map();
  const results = new Array(imageUrls.length);
  let nextIndex = 0;

  async function downloadOne(sourceUrl, index) {
    const number = String(index + 1).padStart(3, '0');
    let lastError = null;
    for (let attempt = 1; attempt <= 2; attempt += 1) {
      try {
        const { buffer, contentType } = await fetchImageBuffer(
          sourceUrl,
          cookieHeader,
          options.imageTimeoutMs,
        );
        const detected = detectImageType(buffer, contentType);
        if (!detected) {
          throw new ConversionError(
            `响应不是受支持的图片格式（${contentType || '未知内容类型'}，${buffer.length} 字节）`,
            'IMAGE_INVALID',
          );
        }
        const filename = `图片-${number}${detected.extension}`;
        const destination = path.join(stageAssetsPath, filename);
        fs.writeFileSync(destination, buffer);
        const relative = `./${assetsBaseName}/${filename}`.replace(/\\/g, '/');
        imageMap.set(sourceUrl, relative);
        results[index] = {
          index: index + 1,
          filename,
          bytes: buffer.length,
          mediaType: detected.mediaType,
          status: 'ok',
        };
        console.error(`  图片 ${number}/${String(imageUrls.length).padStart(3, '0')}：完成`);
        return;
      } catch (error) {
        lastError = error;
        if (attempt < 2) await delay(500);
      }
    }

    if (options.allowRemoteImages) imageMap.set(sourceUrl, sourceUrl);
    results[index] = {
      index: index + 1,
      filename: '',
      bytes: 0,
      mediaType: '',
      status: 'failed',
      reason: lastError?.message || '未知错误',
    };
    console.error(`  图片 ${number}/${String(imageUrls.length).padStart(3, '0')}：失败`);
  }

  async function worker() {
    while (true) {
      const index = nextIndex;
      nextIndex += 1;
      if (index >= imageUrls.length) return;
      await downloadOne(imageUrls[index], index);
    }
  }

  console.error(`[3/5] 下载并校验 ${imageUrls.length} 张唯一图片`);
  await Promise.all(Array.from({ length: options.concurrency }, () => worker()));
  const failed = results.filter((result) => result.status === 'failed');
  if (failed.length && !options.allowRemoteImages) {
    throw new ConversionError(
      `${failed.length} 张图片下载失败；旧输出未被替换。仅在用户接受远程图片回退时使用 --allow-remote-images`,
      'IMAGE_FAILED',
    );
  }
  return { imageMap, results, failed };
}

function htmlEscape(text) {
  return String(text)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function markdownEscape(text) {
  return String(text)
    .replace(/\\/g, '\\\\')
    .replace(/([`*_\[\]<>])/g, '\\$1');
}

function markSignature(marks) {
  return JSON.stringify(
    [...(marks || [])]
      .map((mark) => ({ type: mark.type, value: mark.value, data: mark.data }))
      .sort((left, right) =>
        (left.type + JSON.stringify(left.value) + JSON.stringify(left.data)).localeCompare(
          right.type + JSON.stringify(right.value) + JSON.stringify(right.data),
        ),
      ),
  );
}

function markValue(mark) {
  return mark?.value ?? mark?.data ?? null;
}

function colorValue(mark) {
  const value = markValue(mark);
  if (typeof value === 'string') return value;
  if (value && typeof value === 'object') return value.color || value.value || '';
  return '';
}

function linkValue(mark) {
  const value = markValue(mark);
  if (typeof value === 'string') return value;
  if (value && typeof value === 'object') return value.href || value.url || '';
  return '';
}

function safeLinkDestination(value) {
  const destination = String(value || '').trim();
  if (!destination) return '';
  const scheme = /^([A-Za-z][A-Za-z0-9+.-]*):/.exec(destination)?.[1]?.toLowerCase();
  if (scheme && !['http', 'https', 'mailto'].includes(scheme)) return '';
  return destination;
}

function renderRun(text, marks) {
  if (!text) return '';
  const types = new Set((marks || []).map((mark) => String(mark.type || '').toLowerCase()));
  const colorMark = (marks || []).find((mark) => String(mark.type).toLowerCase() === 'color');
  const backgroundMark = (marks || []).find((mark) =>
    ['backgroundcolor', 'bgcolor', 'highlight'].includes(String(mark.type).toLowerCase()),
  );
  const linkMark = (marks || []).find((mark) =>
    ['link', 'hyperlink'].includes(String(mark.type).toLowerCase()),
  );
  const color = colorMark ? colorValue(colorMark) : '';
  const background = backgroundMark ? colorValue(backgroundMark) : '';
  const underline = types.has('underline');
  const strike = types.has('strike') || types.has('strikethrough');
  const code = types.has('code') || types.has('inlinecode');
  const italic = types.has('italic') || types.has('em');
  const bold = types.has('bold') || types.has('strong');
  const needsHtml = underline || strike || code || Boolean(color) || Boolean(background);

  let value = needsHtml ? htmlEscape(text) : markdownEscape(text);
  if (code) value = `<code>${value}</code>`;
  if (bold) value = needsHtml ? `<strong>${value}</strong>` : `**${value}**`;
  if (italic) value = needsHtml ? `<em>${value}</em>` : `*${value}*`;
  if (strike) value = `<del>${value}</del>`;
  if (underline) value = `<u>${value}</u>`;

  const style = [];
  if (/^#[0-9A-Fa-f]{3,8}$/.test(color)) style.push(`color: ${color}`);
  if (/^#[0-9A-Fa-f]{3,8}$/.test(background)) style.push(`background-color: ${background}`);
  if (style.length) value = `<span style="${style.join('; ')};">${value}</span>`;

  const link = linkMark ? safeLinkDestination(linkValue(linkMark)) : '';
  if (link) {
    value = needsHtml
      ? `<a href="${htmlEscape(link)}">${value}</a>`
      : `[${value}](${formatMarkdownDestination(link)})`;
  }
  return value;
}

function createRenderer(document, imageUrls, imageMap) {
  const imageIndex = new Map(imageUrls.map((url, index) => [url, index]));
  const listBaseLevels = new Map();
  walkLeaves(document.leaves, (node) => {
    if (node.name !== 'list-item') return;
    const listId = node.data?.listId || '__default_list__';
    const rawLevel = Number(node.data?.listLevel);
    const level = Number.isFinite(rawLevel) ? rawLevel : 0;
    const current = listBaseLevels.get(listId);
    if (current === undefined || level < current) listBaseLevels.set(listId, level);
  });

  function imageMarkdown(node) {
    const url = imageUrlForNode(node);
    const index = imageIndex.get(url);
    const number = index === undefined ? '' : String(index + 1).padStart(3, '0');
    const altSource = node?.data?.alt || node?.data?.title;
    const alt = typeof altSource === 'string' && altSource.trim() ? altSource.trim() : `图片 ${number}`;
    const destination = imageMap.get(url) || url;
    return destination
      ? `![${markdownEscape(alt)}](${formatMarkdownDestination(destination)})`
      : `![${markdownEscape(alt)}]()`;
  }

  function renderInline(items) {
    let output = '';
    let run = '';
    let marks = [];
    let signature = null;
    const flush = () => {
      if (run) output += renderRun(run, marks);
      run = '';
      marks = [];
      signature = null;
    };

    for (const item of items || []) {
      if (typeof item?.text === 'string') {
        const nextSignature = markSignature(item.marks || []);
        if (signature !== null && signature !== nextSignature) flush();
        if (signature === null) {
          signature = nextSignature;
          marks = item.marks || [];
        }
        run += item.text;
      } else if (item?.name === 'image') {
        flush();
        output += imageMarkdown(item);
      } else if (item?.type === 'split-text') {
        // split-text 只表示编辑器内部文本分段，不产生可见字符。
      } else if (item?.name === 'link' && Array.isArray(item.leaves)) {
        flush();
        const inner = renderInline(item.leaves);
        const href = safeLinkDestination(item.data?.href || item.data?.url);
        output += href ? `[${inner}](${formatMarkdownDestination(href)})` : inner;
      } else if (Array.isArray(item?.leaves)) {
        flush();
        output += renderInline(item.leaves);
      }
    }
    flush();
    return output;
  }

  function parseTokens(leaves) {
    const tokens = [];
    let index = 0;
    while (index < (leaves || []).length) {
      const node = leaves[index];
      if (node?.type === 'split-block') {
        const content = [];
        index += 1;
        while (index < leaves.length) {
          const current = leaves[index];
          if (current && (current.type === 'split-block' || current.type === 'block')) break;
          content.push(current);
          index += 1;
        }
        const inline = renderInline(content);
        if (node.name === 'heading') {
          if (inline.trim()) {
            const match = /h([1-6])/.exec(String(node.data?.level || 'h2'));
            const level = match ? Number(match[1]) : 2;
            const anchor = node.id ? `<a id="${htmlEscape(node.id)}"></a>\n` : '';
            tokens.push({ kind: 'heading', text: `${anchor}${'#'.repeat(level)} ${inline}` });
          }
        } else if (node.name === 'list-item') {
          const listId = node.data?.listId || '__default_list__';
          const rawLevel = Number(node.data?.listLevel);
          const baseLevel = listBaseLevels.get(listId) ?? 0;
          const depth = Number.isFinite(rawLevel) ? Math.max(0, rawLevel - baseLevel) : 0;
          const listType = String(node.data?.listType || '');
          const marker = /^(ordered|number|numbered|decimal|ol)$/i.test(listType) ? '1. ' : '- ';
          tokens.push({
            kind: 'list',
            listId,
            text: `${'  '.repeat(depth)}${marker}${inline}`,
          });
        } else if (node.name === 'paragraph') {
          if (inline.trim()) tokens.push({ kind: 'paragraph', text: inline });
        } else if (inline.trim()) {
          tokens.push({ kind: 'paragraph', text: inline });
        }
        continue;
      }

      if (node?.type === 'block') {
        const token = renderBlock(node);
        if (token) tokens.push(token);
        index += 1;
        continue;
      }

      if (node && (typeof node.text === 'string' || node.type === 'inline')) {
        const content = [];
        while (index < leaves.length) {
          const current = leaves[index];
          if (current && (current.type === 'split-block' || current.type === 'block')) break;
          content.push(current);
          index += 1;
        }
        const inline = renderInline(content);
        if (inline.trim()) tokens.push({ kind: 'paragraph', text: inline });
        continue;
      }
      index += 1;
    }
    return tokens;
  }

  function joinTokens(tokens) {
    let output = '';
    let previous = null;
    for (const token of tokens) {
      if (!token?.text) continue;
      if (!output) output = token.text;
      else if (
        previous?.kind === 'list' &&
        token.kind === 'list' &&
        previous.listId === token.listId
      ) {
        output += `\n${token.text}`;
      } else {
        output += `\n\n${token.text}`;
      }
      previous = token;
    }
    return output;
  }

  function cellMarkdown(cell) {
    return joinTokens(parseTokens(cell?.leaves || []))
      .trim()
      .replace(/\r?\n/g, '<br>')
      .replace(/\|/g, '\\|');
  }

  function renderTable(node) {
    const rowNodes = (node.leaves || []).filter((row) => row.name === 'table-row');
    const configured = Array.isArray(node.data?.colsWidth) ? node.data.colsWidth.length : 0;
    const logicalWidths = rowNodes.map((row) =>
      (row.leaves || [])
        .filter((cell) => cell.name === 'table-cell')
        .reduce((sum, cell) => sum + Math.max(1, Number(cell.data?.colSpan) || 1), 0),
    );
    let columnCount = Math.max(1, configured, ...logicalWidths);
    const activeRowSpans = new Array(columnCount).fill(0);
    const rows = [];

    for (const row of rowNodes) {
      const occupied = activeRowSpans.map((value) => value > 0);
      for (let column = 0; column < activeRowSpans.length; column += 1) {
        if (activeRowSpans[column] > 0) activeRowSpans[column] -= 1;
      }
      const cells = new Array(columnCount).fill('');
      let searchColumn = 0;

      for (const cell of (row.leaves || []).filter((value) => value.name === 'table-cell')) {
        const colSpan = Math.max(1, Number(cell.data?.colSpan) || 1);
        const rowSpan = Math.max(1, Number(cell.data?.rowSpan) || 1);
        let column = searchColumn;
        while (true) {
          while (column < occupied.length && occupied[column]) column += 1;
          const rangeFree = Array.from({ length: colSpan }, (_, offset) => !occupied[column + offset]).every(
            Boolean,
          );
          if (rangeFree) break;
          column += 1;
        }

        const requiredWidth = column + colSpan;
        if (requiredWidth > columnCount) {
          while (cells.length < requiredWidth) cells.push('');
          while (occupied.length < requiredWidth) occupied.push(false);
          while (activeRowSpans.length < requiredWidth) activeRowSpans.push(0);
          columnCount = requiredWidth;
        }

        cells[column] = cellMarkdown(cell);
        for (let offset = 0; offset < colSpan; offset += 1) {
          occupied[column + offset] = true;
          if (rowSpan > 1) {
            activeRowSpans[column + offset] = Math.max(
              activeRowSpans[column + offset],
              rowSpan - 1,
            );
          }
        }
        searchColumn = column + colSpan;
      }
      rows.push(cells);
    }

    const width = Math.max(columnCount, ...rows.map((row) => row.length));
    for (const row of rows) while (row.length < width) row.push('');
    const rowLine = (row) => `| ${row.join(' | ')} |`;
    const separator = `| ${new Array(width).fill('---').join(' | ')} |`;
    if (!rows.length) return `${rowLine(new Array(width).fill(''))}\n${separator}`;
    return [rowLine(rows[0]), separator, ...rows.slice(1).map(rowLine)].join('\n');
  }

  function renderBlock(node) {
    if (node.name === 'hr') return { kind: 'hr', text: '---' };
    if (node.name === 'image') return { kind: 'image', text: imageMarkdown(node) };
    if (node.name === 'table') return { kind: 'table', text: renderTable(node) };
    if (node.name === 'quote') {
      const inner = joinTokens(parseTokens(node.leaves || [])).trim();
      return inner
        ? {
            kind: 'quote',
            text: inner
              .split(/\r?\n/)
              .map((line) => (line ? `> ${line}` : '>'))
              .join('\n'),
          }
        : null;
    }
    if (Array.isArray(node.leaves)) {
      const inner = joinTokens(parseTokens(node.leaves));
      if (inner.trim()) return { kind: 'block', text: inner };
    }
    return null;
  }

  return {
    render() {
      return joinTokens(parseTokens(document.leaves)).replace(/\n{4,}/g, '\n\n\n').trim();
    },
  };
}

function validateStagedImages(results, stageAssetsPath) {
  const missing = [];
  const invalid = [];
  for (const result of results) {
    if (result.status !== 'ok') continue;
    const filePath = path.join(stageAssetsPath, result.filename);
    if (!fs.existsSync(filePath)) {
      missing.push(result.filename);
      continue;
    }
    const buffer = fs.readFileSync(filePath);
    if (!detectImageType(buffer, result.mediaType)) invalid.push(result.filename);
  }
  return { missing, invalid };
}

function replaceOutputsAtomically({
  stageMarkdownPath,
  stageAssetsPath,
  outputPath,
  assetsPath,
  hasAssets,
  overwrite,
}) {
  const outputExists = fs.existsSync(outputPath);
  const assetsExist = fs.existsSync(assetsPath);
  if (!overwrite && (outputExists || assetsExist)) {
    throw new ConversionError(
      '输出文档或同名图片目录已存在；确认更新任务后使用 --overwrite',
      'OUTPUT_EXISTS',
    );
  }

  const nonce = `${process.pid}-${Date.now()}`;
  const markdownBackup = `${outputPath}.lingxi-backup-${nonce}`;
  const assetsBackup = `${assetsPath}.lingxi-backup-${nonce}`;
  let markdownBackedUp = false;
  let assetsBackedUp = false;
  let newMarkdownInstalled = false;
  let newAssetsInstalled = false;

  try {
    if (outputExists) {
      fs.renameSync(outputPath, markdownBackup);
      markdownBackedUp = true;
    }
    if (assetsExist) {
      fs.renameSync(assetsPath, assetsBackup);
      assetsBackedUp = true;
    }
    if (hasAssets) {
      fs.renameSync(stageAssetsPath, assetsPath);
      newAssetsInstalled = true;
    }
    fs.renameSync(stageMarkdownPath, outputPath);
    newMarkdownInstalled = true;
  } catch (error) {
    try {
      if (newMarkdownInstalled && fs.existsSync(outputPath)) fs.rmSync(outputPath, { force: true });
      if (newAssetsInstalled && fs.existsSync(assetsPath)) {
        fs.rmSync(assetsPath, { recursive: true, force: true });
      }
      if (markdownBackedUp && fs.existsSync(markdownBackup)) fs.renameSync(markdownBackup, outputPath);
      if (assetsBackedUp && fs.existsSync(assetsBackup)) fs.renameSync(assetsBackup, assetsPath);
    } catch (rollbackError) {
      throw new ConversionError(
        `替换失败且自动回滚也失败：${error.message}；回滚错误：${rollbackError.message}`,
        'ROLLBACK_FAILED',
      );
    }
    throw new ConversionError(`安全替换输出失败，旧文件已恢复：${error.message}`, 'OUTPUT_FAILED');
  }

  // 新输出已经完整安装，备份清理失败只留下可恢复文件，不能反向破坏新旧一致性。
  const cleanupWarnings = [];
  if (markdownBackedUp) {
    try {
      fs.rmSync(markdownBackup, { force: true });
    } catch (error) {
      cleanupWarnings.push(`旧文档备份未清理：${error.message}`);
    }
  }
  if (assetsBackedUp) {
    try {
      fs.rmSync(assetsBackup, { recursive: true, force: true });
    } catch (error) {
      cleanupWarnings.push(`旧图片备份未清理：${error.message}`);
    }
  }
  return cleanupWarnings;
}

async function main() {
  const options = parseArguments(process.argv.slice(2));
  if (options.help) {
    printHelp();
    return;
  }

  const { source, documentId } = parseSourceUrl(options.url);
  const chromePath = resolveChrome(options.chrome);
  const officeUrl = await createOfficeEntry(source, documentId, options.timeoutMs);
  const browser = await launchChrome(chromePath, options.timeoutMs);

  let stageMarkdownPath = '';
  let stageAssetsPath = '';
  try {
    const capture = await captureDocument(
      browser,
      officeUrl,
      source.toString(),
      options.timeoutMs,
    );
    const document = capture.document;
    if (!Array.isArray(document.leaves) || document.leaves.length === 0) {
      throw new ConversionError('实时正文为空或不是受支持的灵犀文本文档', 'UNSUPPORTED_DOCUMENT');
    }

    const analysis = analyzeDocument(document);
    if (analysis.statistics.textCharacters === 0 && analysis.imageUrls.length === 0) {
      throw new ConversionError('正文没有可转换的文字或图片', 'UNSUPPORTED_DOCUMENT');
    }

    const output = resolveOutputPaths(options.output, document, documentId);
    fs.mkdirSync(output.outputDirectory, { recursive: true });
    if (
      !options.overwrite &&
      (fs.existsSync(output.outputPath) || fs.existsSync(output.assetsPath))
    ) {
      throw new ConversionError(
        '输出文档或同名图片目录已存在；确认更新任务后使用 --overwrite',
        'OUTPUT_EXISTS',
      );
    }

    const nonce = `${process.pid}-${Date.now()}-${crypto.randomBytes(4).toString('hex')}`;
    stageMarkdownPath = path.join(
      output.outputDirectory,
      `.${path.basename(output.outputPath)}.lingxi-stage-${nonce}`,
    );
    stageAssetsPath = path.join(
      output.outputDirectory,
      `.${output.assetsBaseName}.lingxi-stage-${nonce}`,
    );

    const downloads = await downloadImages(
      analysis.imageUrls,
      stageAssetsPath,
      output.assetsBaseName,
      capture.officeCookieHeader,
      options,
    );
    const renderer = createRenderer(document, analysis.imageUrls, downloads.imageMap);
    const body = renderer.render();
    if (!body.trim()) {
      throw new ConversionError('转换后的正文为空', 'RENDER_FAILED');
    }

    const title = markdownEscape(document.title || `灵犀文档 ${documentId}`);
    const sourceComment = source.toString().replace(/-->/g, '--&gt;');
    const markdown = `# ${title}\n\n<!-- 原始文档：${sourceComment} -->\n\n${body}\n`;
    fs.writeFileSync(stageMarkdownPath, markdown, 'utf8');

    const stagedValidation = validateStagedImages(downloads.results, stageAssetsPath);
    if (stagedValidation.missing.length || stagedValidation.invalid.length) {
      throw new ConversionError(
        `本地图片复核失败：缺失 ${stagedValidation.missing.length}，格式无效 ${stagedValidation.invalid.length}`,
        'IMAGE_VALIDATION_FAILED',
      );
    }

    console.error('[4/5] 原子替换输出文件');
    replaceOutputsAtomically({
      stageMarkdownPath,
      stageAssetsPath,
      outputPath: output.outputPath,
      assetsPath: output.assetsPath,
      hasAssets: analysis.imageUrls.length > downloads.failed.length,
      overwrite: options.overwrite,
    });
    stageMarkdownPath = '';
    stageAssetsPath = '';

    const localFiles = downloads.results.filter((result) => result.status === 'ok');
    const totalImageBytes = localFiles.reduce((sum, result) => sum + result.bytes, 0);
    const report = {
      success: true,
      sourceUrl: source.toString(),
      title: document.title || '',
      documentId,
      outputPath: output.outputPath,
      assetsPath: localFiles.length ? output.assetsPath : '',
      snapshotPayloadCharacters: capture.payloadChars,
      snapshotPayloadBytes: capture.payloadBytes,
      markdownCharacters: markdown.length,
      markdownLines: markdown.split('\n').length,
      statistics: analysis.statistics,
      uniqueImages: analysis.imageUrls.length,
      imagesDownloaded: localFiles.length,
      imagesFailed: downloads.failed,
      missingLocalImages: stagedValidation.missing.length,
      invalidLocalImages: stagedValidation.invalid.length,
      totalImageBytes,
      unknownBlockNames: analysis.unknownBlockNames,
      usedRemoteImageFallback: downloads.failed.length > 0,
    };
    console.error('[5/5] 转换与校验完成');
    console.log(JSON.stringify(report, null, 2));
  } finally {
    if (stageMarkdownPath && fs.existsSync(stageMarkdownPath)) {
      fs.rmSync(stageMarkdownPath, { force: true });
    }
    if (stageAssetsPath && fs.existsSync(stageAssetsPath)) {
      fs.rmSync(stageAssetsPath, { recursive: true, force: true });
    }
    await browser.cleanup();
  }
}

main().catch((error) => {
  const code = error instanceof ConversionError ? error.code : 'UNEXPECTED_ERROR';
  const message = error instanceof Error ? error.message : String(error);
  console.error(`${TOOL_NAME}失败 [${code}]：${message}`);
  process.exitCode = 1;
});
