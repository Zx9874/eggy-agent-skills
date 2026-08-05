[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [string[]]$Target = @('.'),

    [switch]$FailOnExport
)

$ErrorActionPreference = 'Stop'

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

function Test-PathInsideProject {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectRoot,

        [Parameter(Mandatory = $true)]
        [string]$Candidate
    )

    $root = $ProjectRoot.TrimEnd('\')
    $path = $Candidate.TrimEnd('\')
    if ($path.Equals($root, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $true
    }

    return $path.StartsWith(
        $root + '\',
        [System.StringComparison]::OrdinalIgnoreCase
    )
}

function Normalize-Field {
    param([AllowNull()][string]$Value)

    if ($null -eq $Value) {
        return ''
    }

    return (($Value -replace '\|', '/') -replace '\s+', ' ').Trim()
}

$project = Resolve-ExistingPath -Path $ProjectPath -Label 'Project path'

$normalizedTargets = @()
foreach ($rawTarget in $Target) {
    $normalizedTargets += @(
        $rawTarget -split ',' |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ }
    )
}
if ($normalizedTargets.Count -eq 0) {
    throw 'Target does not contain a usable value.'
}

$targetPaths = @()
$luaFilesByPath = @{}
foreach ($targetValue in $normalizedTargets) {
    $candidate = if ([System.IO.Path]::IsPathRooted($targetValue)) {
        $targetValue
    } else {
        Join-Path $project $targetValue
    }

    $resolvedTarget = Resolve-ExistingPath -Path $candidate -Label 'Target path'
    if (-not (Test-PathInsideProject -ProjectRoot $project -Candidate $resolvedTarget)) {
        throw "Target path is outside the project: $resolvedTarget"
    }

    $targetPaths += $resolvedTarget
    $item = Get-Item -LiteralPath $resolvedTarget
    $files = if ($item.PSIsContainer) {
        @(Get-ChildItem -LiteralPath $resolvedTarget -Recurse -File -Filter '*.lua')
    } elseif ($item.Extension.Equals('.lua', [System.StringComparison]::OrdinalIgnoreCase)) {
        @($item)
    } else {
        @()
    }

    foreach ($file in $files) {
        $luaFilesByPath[$file.FullName.ToLowerInvariant()] = $file
    }
}

$luaFiles = @($luaFilesByPath.Values | Sort-Object FullName)
$contracts = @()
$brokenAnnotations = @()

foreach ($file in $luaFiles) {
    $lines = @(Get-Content -LiteralPath $file.FullName -Encoding UTF8)
    for ($index = 0; $index -lt $lines.Count; $index++) {
        $annotationMatch = [regex]::Match(
            $lines[$index],
            '^\s*---@(?<kind>export(?:_plugin)?)\s*$'
        )
        if (-not $annotationMatch.Success) {
            continue
        }

        $annotationLine = $index + 1
        $kind = $annotationMatch.Groups['kind'].Value.ToUpperInvariant()
        $description = ''
        $parameters = @()
        $parameterNames = @()
        $returns = @()
        $functionFound = $false
        $scanLimit = [Math]::Min($lines.Count - 1, $index + 40)

        for ($cursor = $index + 1; $cursor -le $scanLimit; $cursor++) {
            $line = $lines[$cursor]

            if ([regex]::IsMatch($line, '^\s*---@export(?:_plugin)?\s*$')) {
                break
            }

            $functionMatch = [regex]::Match(
                $line,
                '^\s*(?<local>local\s+)?function\s+(?<name>[^\s(]+)\s*\((?<params>[^)]*)\)'
            )
            if ($functionMatch.Success) {
                $declaredParameterNames = @(
                    $functionMatch.Groups['params'].Value -split ',' |
                        ForEach-Object { $_.Trim() } |
                        Where-Object { $_ }
                )
                $issues = @()
                if ($functionMatch.Groups['local'].Success) {
                    $issues += 'EXPORTED_FUNCTION_IS_LOCAL'
                }
                if (($declaredParameterNames -join ',') -ne ($parameterNames -join ',')) {
                    $issues += 'DECLARED_AND_ANNOTATED_PARAMETERS_DIFFER'
                }

                $contracts += [pscustomobject]@{
                    Kind = $kind
                    File = $file.FullName
                    AnnotationLine = $annotationLine
                    FunctionLine = $cursor + 1
                    Name = $functionMatch.Groups['name'].Value
                    DeclaredParameters = Normalize-Field $functionMatch.Groups['params'].Value
                    AnnotatedParameters = Normalize-Field ($parameters -join '; ')
                    Returns = Normalize-Field ($returns -join '; ')
                    Description = Normalize-Field $description
                    IsLocal = $functionMatch.Groups['local'].Success
                    Issues = Normalize-Field ($issues -join '; ')
                }
                $functionFound = $true
                break
            }

            $descriptionMatch = [regex]::Match($line, '^\s*---@desc\s+(?<value>.*)$')
            if ($descriptionMatch.Success) {
                $description = $descriptionMatch.Groups['value'].Value
                continue
            }

            $parameterMatch = [regex]::Match(
                $line,
                '^\s*---@param\s+(?<name>\S+)\s+(?<type>\S+)(?:\s+(?<description>.*))?$'
            )
            if ($parameterMatch.Success) {
                $parameterText = "{0}:{1}" -f `
                    $parameterMatch.Groups['name'].Value,
                    $parameterMatch.Groups['type'].Value
                if ($parameterMatch.Groups['description'].Success) {
                    $parameterText += ':' + $parameterMatch.Groups['description'].Value
                }
                $parameters += $parameterText
                $parameterNames += $parameterMatch.Groups['name'].Value
                continue
            }

            $returnMatch = [regex]::Match(
                $line,
                '^\s*---@return\s+(?<value>.*)$'
            )
            if ($returnMatch.Success) {
                $returns += $returnMatch.Groups['value'].Value
                continue
            }

            if ([string]::IsNullOrWhiteSpace($line) -or [regex]::IsMatch($line, '^\s*--')) {
                continue
            }

            break
        }

        if (-not $functionFound) {
            $brokenAnnotations += [pscustomobject]@{
                Kind = $kind
                File = $file.FullName
                AnnotationLine = $annotationLine
            }
        }
    }
}

Write-Output 'EXPORT_CONTRACT_AUDIT_VERSION=2'
Write-Output "PROJECT=$project"
foreach ($targetPath in $targetPaths) {
    Write-Output "TARGET=$targetPath"
}
Write-Output "LUA_FILES_SCANNED=$($luaFiles.Count)"

foreach ($contract in $contracts) {
    Write-Output (
        'CONTRACT|{0}|{1}:{2}|FUNCTION={3}|FUNCTION_LINE={4}|DECLARED_PARAMS={5}|ANNOTATED_PARAMS={6}|RETURNS={7}|LOCAL={8}|DESC={9}' -f `
            $contract.Kind,
            $contract.File,
            $contract.AnnotationLine,
            (Normalize-Field $contract.Name),
            $contract.FunctionLine,
            $contract.DeclaredParameters,
            $contract.AnnotatedParameters,
            $contract.Returns,
            $contract.IsLocal.ToString().ToUpperInvariant(),
            $contract.Description
    )
    if ($contract.Issues) {
        Write-Output (
            'CONTRACT_ISSUE|{0}:{1}|FUNCTION={2}|ISSUES={3}' -f `
                $contract.File,
                $contract.FunctionLine,
                (Normalize-Field $contract.Name),
                $contract.Issues
        )
    }
}

foreach ($broken in $brokenAnnotations) {
    Write-Output (
        'BROKEN_ANNOTATION|{0}|{1}:{2}|No function declaration found after annotation' -f `
            $broken.Kind,
            $broken.File,
            $broken.AnnotationLine
    )
}

Write-Output "EXTERNAL_CONTRACTS=$($contracts.Count)"
Write-Output "BROKEN_ANNOTATIONS=$($brokenAnnotations.Count)"
Write-Output "CONTRACT_ISSUES=$(@($contracts | Where-Object { $_.Issues }).Count)"

$requiresReview = ($contracts.Count -gt 0) -or ($brokenAnnotations.Count -gt 0)
if ($requiresReview) {
    Write-Output 'EXPORT_CONTRACT_AUDIT_RESULT=EXTERNAL_CONTRACTS_FOUND'
    if ($FailOnExport) {
        throw 'External export contracts were found. Stop the deletion, rename, move, or signature change and obtain explicit user confirmation.'
    }
} else {
    Write-Output 'EXPORT_CONTRACT_AUDIT_RESULT=NO_EXTERNAL_CONTRACTS'
}
