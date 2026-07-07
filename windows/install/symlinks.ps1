#Requires -Version 5.1

param(
    [Parameter(Mandatory)]
    [string]$DotfilesRoot,

    [Parameter(Mandatory)]
    [string]$ProfilePath
)

$ErrorActionPreference = "Stop"

function Install-DotfileSymlink {
    param(
        [Parameter(Mandatory)]
        [string]$LinkPath,

        [Parameter(Mandatory)]
        [string]$TargetPath
    )

    $linkPath = [System.IO.Path]::GetFullPath($LinkPath)
    $targetPath = [System.IO.Path]::GetFullPath($TargetPath)
    if (-not (Test-Path -LiteralPath $targetPath)) {
        throw "Symlink target not found: $targetPath"
    }

    $linkParent = Split-Path -Parent $linkPath
    if (-not (Test-Path -LiteralPath $linkParent)) {
        New-Item -ItemType Directory -Path $linkParent -Force | Out-Null
    }

    $existing = Get-Item -LiteralPath $linkPath -Force -ErrorAction SilentlyContinue
    if ($existing) {
        if ($existing.LinkType) {
            $existingTarget = [System.IO.Path]::GetFullPath((@($existing.Target))[0])
            if ($existingTarget -eq $targetPath) {
                Write-Host "  OK: $linkPath" -ForegroundColor DarkGray
                return
            }
            Remove-Item -LiteralPath $linkPath -Force
        } else {
            throw "Cannot create symlink; path exists and is not a symlink: $linkPath"
        }
    }

    $targetIsDirectory = Test-Path -LiteralPath $targetPath -PathType Container
    $mklinkArgs = if ($targetIsDirectory) {
        @('/c', 'mklink', '/D', $linkPath, $targetPath)
    } else {
        @('/c', 'mklink', $linkPath, $targetPath)
    }

    $mklinkOutput = & cmd.exe @mklinkArgs 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw ($mklinkOutput | Out-String).Trim()
    }

    Write-Host "  Linked: $linkPath -> $targetPath" -ForegroundColor Green
}

$symlinks = @(
    @{ Link = $ProfilePath; Target = 'windows\install\powershell.ps1' }
    @{ Link = "$env:USERPROFILE\.config\wezterm"; Target = 'config\wezterm' }
    @{ Link = "$env:USERPROFILE\.config\starship.toml"; Target = 'config\starship.toml' }
    @{ Link = "$env:USERPROFILE\.config\ideavim"; Target = 'config\ideavim' }
    @{ Link = "$env:USERPROFILE\.ideavimrc"; Target = 'config\ideavim\.ideavimrc' }
    @{ Link = "$env:LOCALAPPDATA\nvim"; Target = 'config\nvim' }
    @{ Link = "$env:APPDATA\bat"; Target = 'config\bat' }
)

foreach ($entry in $symlinks) {
    $target = Join-Path $DotfilesRoot $entry.Target
    Install-DotfileSymlink -LinkPath $entry.Link -TargetPath $target
}
