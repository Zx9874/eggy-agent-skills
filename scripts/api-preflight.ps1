[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [Parameter(Mandatory = $true)]
    [string[]]$ApiName,

    [Parameter(Mandatory = $true)]
    [string]$DocsRoot,

    [string]$ExamplesRoot,

    [ValidateRange(1, 50)]
    [int]$MaxHits = 8
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

function Resolve-ExistingPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "$Label does not exist: $Path"
    }

    return (Resolve-Path -LiteralPath $Path).Path
}

function Get-SearchFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root,

        [Parameter(Mandatory = $true)]
        [string[]]$Extensions
    )

    $allowed = @{}
    foreach ($extension in $Extensions) {
        $allowed[$extension.ToLowerInvariant()] = $true
    }

    return @(
        Get-ChildItem -LiteralPath $Root -Recurse -File |
            Where-Object { $allowed.ContainsKey($_.Extension.ToLowerInvariant()) }
    )
}

function Find-Literal {
    param(
        [Parameter(Mandatory = $true)]
        [System.IO.FileInfo[]]$Files,

        [Parameter(Mandatory = $true)]
        [string]$Term,

        [Parameter(Mandatory = $true)]
        [int]$Limit
    )

    if ($Files.Count -eq 0) {
        return @()
    }

    return @(
        Select-String -LiteralPath $Files.FullName -SimpleMatch -Pattern $Term -Encoding UTF8 |
            Select-Object -First $Limit
    )
}

function Write-Hits {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Kind,

        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$Hits
    )

    if ($Hits.Count -eq 0) {
        Write-Output "$Kind|NO_HIT"
        return
    }

    foreach ($hit in $Hits) {
        $line = ($hit.Line -replace '\s+', ' ').Trim()
        if ($line.Length -gt 300) {
            $line = $line.Substring(0, 300) + '...'
        }

        Write-Output ("{0}|{1}:{2}|{3}" -f $Kind, $hit.Path, $hit.LineNumber, $line)
    }
}

$project = Resolve-ExistingPath -Path $ProjectPath -Label 'Project path'
$docs = Resolve-ExistingPath -Path $DocsRoot -Label 'Documentation root'
$examples = $null
if ($ExamplesRoot) {
    $examples = Resolve-ExistingPath -Path $ExamplesRoot -Label 'Examples root'
}

$projectEdition = Get-EggyProjectEdition -ProjectPath $project
$edition = if ($projectEdition -eq 'World') { 'WORLD' } else { 'ORIGIN' }
$definitionFiles = @(
    'EggyAPI.lua',
    'EggyEditorAPI.lua'
) | ForEach-Object { Join-Path $project $_ } | Where-Object { Test-Path -LiteralPath $_ } | ForEach-Object { Get-Item -LiteralPath $_ }

if ($definitionFiles.Count -eq 0) {
    throw "No API definition file found in current project: $project"
}

$docFiles = Get-SearchFiles -Root $docs -Extensions @('.md', '.lua', '.txt')
$exampleFiles = @()
if ($examples) {
    $exampleFiles = Get-SearchFiles -Root $examples -Extensions @('.md', '.lua', '.txt')
}

$normalizedApiNames = @()
foreach ($rawName in $ApiName) {
    $normalizedApiNames += @(
        $rawName -split ',' |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ }
    )
}
if ($normalizedApiNames.Count -eq 0) {
    throw 'ApiName does not contain a usable value.'
}

Write-Output "API_PREFLIGHT_VERSION=1"
Write-Output "PROJECT=$project"
Write-Output "EDITION=$edition"
Write-Output "DEFINITION_FILES=$($definitionFiles.Count)"
Write-Output "DOC_FILES=$($docFiles.Count)"
Write-Output "EXAMPLE_FILES=$($exampleFiles.Count)"

$missingDefinitions = @()
foreach ($name in $normalizedApiNames) {
    $term = $name.Trim()
    if (-not $term) {
        throw 'ApiName contains an empty value.'
    }

    Write-Output "BEGIN_API=$term"
    $definitionHits = @(Find-Literal -Files $definitionFiles -Term $term -Limit $MaxHits)
    $documentationHits = @(Find-Literal -Files $docFiles -Term $term -Limit $MaxHits)
    $exampleHits = @(
        if ($examples) {
            Find-Literal -Files $exampleFiles -Term $term -Limit $MaxHits
        }
    )

    Write-Hits -Kind 'DEF' -Hits $definitionHits
    Write-Hits -Kind 'DOC' -Hits $documentationHits
    if ($examples) {
        Write-Hits -Kind 'EXAMPLE' -Hits $exampleHits
    } else {
        Write-Output 'EXAMPLE|NOT_PROVIDED'
    }

    if ($definitionHits.Count -eq 0) {
        $missingDefinitions += $term
    }
    Write-Output "END_API=$term"
}

if ($missingDefinitions.Count -gt 0) {
    Write-Output "API_PREFLIGHT_RESULT=FAIL"
    throw "Missing current-project definitions: $($missingDefinitions -join ', ')"
}

Write-Output "API_PREFLIGHT_RESULT=SEARCH_HITS_FOUND"
Write-Output 'NEXT_STEP=Read each hit in context and record the exact signature, parameter semantics, limits, and unknowns before editing code.'
