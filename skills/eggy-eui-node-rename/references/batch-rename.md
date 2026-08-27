# 界面节点批量改名模板

## 只读盘点

先确认根名称全图唯一，再只遍历该根：

```lua
local roots = EditorAPI.get_eui_node_ids_by_name('目标根名称')
if roots == nil or roots[1] == nil or roots[2] ~= nil then
    return 'FAIL|root-count'
end

local lines = {}
local function walk(id, depth)
    local name = EditorAPI.get_eui_node_attr(id, 'name')
    local text = EditorAPI.get_eui_node_attr(id, 'text')
    local children = EditorAPI.get_eui_node_children(id)
    lines[#lines + 1] = table.concat({
        tostring(depth), tostring(id),
        tostring(EditorAPI.get_eui_node_type(id)),
        tostring(name), tostring(text)
    }, '|')
    if children ~= nil then
        for _, child in ipairs(children) do
            walk(child, depth + 1)
        end
    end
end

walk(roots[1], 0)
return table.concat(lines, '\n')
```

若同名节点仍无法区分，再补读 `pos`（位置）和 `size`（尺寸）的第一、第二项；不要使用编辑器沙盒里可能不存在的通用表遍历函数。

## 写入前检

为每项准备 `{id, oldName, newName, expectedText}`（节点编号、旧名、新名、预期文字），并在任何写入前同时检查：

1. 根唯一且编号正确；
2. 子级总数、顺序和编号完全一致；
3. 当前名称等于冻结旧名；
4. 文本节点的显示文字等于冻结文字；
5. 计划数量等于预计数量；
6. 所有新名称互不重复。

任一项不符就返回 `FAIL_PRECHECK`（前检失败），不执行部分改名。

## 手动回滚批次

仅在命令行事务能力不可用时采用：

```lua
local changed = {}
local failure = nil

for index, entry in ipairs(plan) do
    changed[#changed + 1] = entry
    local ok, err = pcall(EditorAPI.set_eui_node_name, entry.id, entry.newName)
    local actual = EditorAPI.get_eui_node_attr(entry.id, 'name')
    if not ok or actual ~= entry.newName then
        failure = tostring(index) .. '|' .. tostring(err) .. '|' .. tostring(actual)
        break
    end
end

if failure ~= nil then
    local rollbackIssues = {}
    for index = #changed, 1, -1 do
        local entry = changed[index]
        pcall(EditorAPI.set_eui_node_name, entry.id, entry.oldName)
        if EditorAPI.get_eui_node_attr(entry.id, 'name') ~= entry.oldName then
            rollbackIssues[#rollbackIssues + 1] = tostring(entry.id)
        end
    end
    return 'FAIL_MUTATION|' .. failure .. '|rollback=' .. table.concat(rollbackIssues, ',')
end

return 'OK|renamed=' .. tostring(#plan)
```

这段保护调用只负责恢复并返回失败，不能把异常转成成功。若执行进程本身中断，使用冻结的旧名映射或编辑器撤销记录恢复。

## 独立复核

写入后重新从新根名称定位，逐项检查新名称、显示文字、节点编号和层级。每个新名称再调用一次按名称查找，必须只返回目标编号且没有第二项。最后核对目标总数、文字核对数和地图未保存状态；计数条件应从实际非空文字项计算，不手写未经核对的常量。
