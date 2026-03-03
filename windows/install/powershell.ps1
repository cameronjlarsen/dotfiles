#Module imports
if (-not (Get-Module -ListAvailable -Name PSCompletions)) {
    Install-Module PSCompletions -Scope CurrentUser -Repository PSGallery -Force
}

$script:PSCompletionsLoaded = $false
function Initialize-PSCompletions {
    if ($script:PSCompletionsLoaded) { return }
    if (Get-Module -ListAvailable -Name PSCompletions) {
        Import-Module PSCompletions -ErrorAction SilentlyContinue
    }
    $script:PSCompletionsLoaded = $true
}

function psc {
    Initialize-PSCompletions
    if (Get-Command psc -ErrorAction SilentlyContinue) {
        Remove-Item Function:psc -ErrorAction SilentlyContinue
        & (Get-Command psc -ErrorAction SilentlyContinue) @args
    }
}

$script:TerminalIconsLoaded = $false
function Enable-TerminalIcons {
    if ($script:TerminalIconsLoaded) { return }
    if (Get-Module -ListAvailable -Name Terminal-Icons) {
        Import-Module Terminal-Icons -ErrorAction SilentlyContinue
    }
    $script:TerminalIconsLoaded = $true
}

$script:PSFzfLoaded = $false
function Initialize-PsFzf {
    if ($script:PSFzfLoaded) { return }
    if (Get-Module -ListAvailable -Name PSFzf) {
        Import-Module PSFzf -ErrorAction SilentlyContinue
    }
    $script:PSFzfLoaded = $true
}

Import-Module -Name PSReadLine

Set-PsReadlineOption -EditMode Vi
Set-PsReadlineOption -BellStyle None
if ($Host.UI.SupportsVirtualTerminal -and -not [System.Console]::IsOutputRedirected) {
    Set-PsReadLineOption -PredictionSource History
}

# Aliases
Set-Alias cat 'bat'
Set-Alias catt 'bat --theme=Catppuccin-mocha'

function ls { eza --color=auto --icons=auto --group-directories-first @args }
function la { eza --color=auto --icons=auto --group-directories-first --all --git @args }
function ll { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }
function l { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }

# Key bindings
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
    Initialize-PsFzf
    if (Get-Command Invoke-FzfTabCompletion -ErrorAction SilentlyContinue) {
        Invoke-FzfTabCompletion
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
    }
}
Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock {
    Initialize-PsFzf
    if (Get-Command Invoke-FzfPsReadlineHandlerProvider -ErrorAction SilentlyContinue) {
        Invoke-FzfPsReadlineHandlerProvider
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
    }
}
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
    Initialize-PsFzf
    if (Get-Command Invoke-FzfPsReadlineHandlerHistory -ErrorAction SilentlyContinue) {
        Invoke-FzfPsReadlineHandlerHistory
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ReverseSearchHistory()
    }
}
Set-PSReadLineKeyHandler -Key Alt+c -ScriptBlock {
    Initialize-PsFzf
    if (Get-Command Invoke-FzfPsReadlineHandlerSetLocation -ErrorAction SilentlyContinue) {
        Invoke-FzfPsReadlineHandlerSetLocation
    }
}
Set-PSReadLineKeyHandler -Key Alt+a -ScriptBlock {
    Initialize-PsFzf
    if (Get-Command Invoke-FzfPsReadlineHandlerHistoryArgs -ErrorAction SilentlyContinue) {
        Invoke-FzfPsReadlineHandlerHistoryArgs
    }
}

# Environment variables
$ENV:FZF_DEFAULT_OPTS=@"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=border:#b4befe
--height=50% --layout=reverse --info=inline --border=rounded --margin=1 --padding=1
"@

$ENV:FZF_CTRL_T_OPTS=@"
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'
"@

$ENV:FZF_CTRL_R_OPTS=@"
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into cliboard'
"@

$ENV:FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# add z for directory jumping
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# fnm setup
fnm env --use-on-cd | Out-String | Invoke-Expression
fnm completions | Out-String | Invoke-Expression

# starship prompt
Invoke-Expression (&starship init powershell)
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

