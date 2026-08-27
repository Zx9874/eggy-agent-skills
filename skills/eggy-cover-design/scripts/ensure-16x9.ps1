[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [ValidateRange(0.1, 50.0)]
    [double]$MaxCropPercent = 5.0,

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$inputFullPath = [System.IO.Path]::GetFullPath($InputPath)
$outputFullPath = [System.IO.Path]::GetFullPath($OutputPath)

if (-not [System.IO.File]::Exists($inputFullPath)) {
    throw "Input image does not exist: $inputFullPath"
}

if ($inputFullPath -eq $outputFullPath) {
    throw 'InputPath and OutputPath must be different. This script does not overwrite the source image.'
}

if ([System.IO.File]::Exists($outputFullPath) -and -not $Force) {
    throw "Output image already exists: $outputFullPath. Use -Force only after confirming replacement."
}

$outputDirectory = [System.IO.Path]::GetDirectoryName($outputFullPath)
if (-not [System.IO.Directory]::Exists($outputDirectory)) {
    [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
}

Add-Type -AssemblyName System.Drawing

$source = [System.Drawing.Bitmap]::FromFile($inputFullPath)
try {
    $scale = [math]::Floor([math]::Min($source.Width / 16.0, $source.Height / 9.0))
    if ($scale -lt 1) {
        throw 'Input image is too small to create a 16:9 output.'
    }

    $targetWidth = [int](16 * $scale)
    $targetHeight = [int](9 * $scale)
    $cropWidthPercent = (($source.Width - $targetWidth) / $source.Width) * 100.0
    $cropHeightPercent = (($source.Height - $targetHeight) / $source.Height) * 100.0
    $largestCropPercent = [math]::Max($cropWidthPercent, $cropHeightPercent)

    if ($largestCropPercent -gt $MaxCropPercent) {
        throw ('Required crop is {0:N2}%, exceeding MaxCropPercent {1:N2}%. Regenerate or review the composition.' -f $largestCropPercent, $MaxCropPercent)
    }

    $left = [int][math]::Floor(($source.Width - $targetWidth) / 2.0)
    $top = [int][math]::Floor(($source.Height - $targetHeight) / 2.0)
    $rectangle = [System.Drawing.Rectangle]::new($left, $top, $targetWidth, $targetHeight)
    $cropped = $source.Clone($rectangle, $source.PixelFormat)
    try {
        $cropped.Save($outputFullPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $cropped.Dispose()
    }
}
finally {
    $source.Dispose()
}

$result = [System.Drawing.Image]::FromFile($outputFullPath)
try {
    [PSCustomObject]@{
        OutputPath = $outputFullPath
        Width = $result.Width
        Height = $result.Height
        Ratio = [math]::Round($result.Width / $result.Height, 6)
    }
}
finally {
    $result.Dispose()
}
