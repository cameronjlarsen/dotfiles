#Requires -Version 5.1

<#
.SYNOPSIS
    Sets up the Windows development environment.

.DESCRIPTION
    Installs packages via winget and Scoop, then symlinks dotfiles configs
    (PowerShell profile, wezterm, starship, ideavim, nvim, bat).
    Safe to run multiple times.

.PARAMETER SymlinksOnly
    Skip winget and Scoop setup; only recreate dotfile symlinks.

.PARAMETER ProfileOnly
    Alias for -SymlinksOnly. Kept for backward compatibility.

.PARAMETER SkipWinget
    Skip winget setup.

.PARAMETER SkipScoop
    Skip Scoop setup.

.EXAMPLE
    .\install.ps1 -SymlinksOnly
    Recreate all dotfile symlinks only.

.EXAMPLE
    .\install.ps1 -ProfileOnly
    Recreate all dotfile symlinks only (alias for -SymlinksOnly).

.EXAMPLE
    .\install.ps1 -SkipWinget
    Run Scoop setup and recreate dotfile symlinks.

.EXAMPLE
    .\install.ps1 -SkipScoop
    Run winget setup and recreate dotfile symlinks.
#>

[CmdletBinding()]
param(
    [switch]$SymlinksOnly,
    [switch]$ProfileOnly,
    [switch]$SkipWinget,
    [switch]$SkipScoop
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$dotfilesRoot = (Resolve-Path (Join-Path $scriptDir '..\..')).Path

$skipWinget = $SymlinksOnly -or $ProfileOnly -or $SkipWinget
$skipScoop = $SymlinksOnly -or $ProfileOnly -or $SkipScoop

Write-Host "==> Setting up Windows development environment..." -ForegroundColor Cyan

# Check if running as administrator (Scoop requires a regular user)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $skipScoop -and $isAdmin) {
    Write-Host "ERROR: This script must NOT be run as Administrator!" -ForegroundColor Red
    Write-Host "Scoop requires running as a regular user." -ForegroundColor Yellow
    exit 1
}

if (-not $skipWinget) {
    Write-Host "==> Running winget setup..." -ForegroundColor Cyan
    & "$scriptDir\winget.ps1"
    if ($LASTEXITCODE -ne 0) { throw "Winget setup failed" }
} else {
    Write-Host "==> Skipping winget setup" -ForegroundColor DarkGray
}

if (-not $skipScoop) {
    Write-Host "==> Running scoop setup..." -ForegroundColor Cyan
    & "$scriptDir\scoop.ps1"
    if ($LASTEXITCODE -ne 0) { throw "Scoop setup failed" }
} else {
    Write-Host "==> Skipping scoop setup" -ForegroundColor DarkGray
}

Write-Host "==> Setting up dot files..." -ForegroundColor Cyan
& "$scriptDir\symlinks.ps1" -DotfilesRoot $dotfilesRoot -ProfilePath $PROFILE -AllHostsProfilePath $PROFILE.CurrentUserAllHosts

Write-Host "`n==> Setup complete!" -ForegroundColor Cyan
