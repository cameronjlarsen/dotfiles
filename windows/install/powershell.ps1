#Module imports
Install-Module PSCompletions -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name PSCompletions
Import-Module -Name Terminal-Icons
Import-Module -Name PSReadLine

# General
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

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

Set-PsReadlineOption -EditMode Vi
Set-PsReadlineOption -BellStyle None
Set-PsReadLineOption -PredictionSource History

# Aliases
Set-Alias cat 'bat'
Set-Alias catt 'bat --theme=Catppuccin-mocha'

function ls { eza --color=auto --icons=auto --group-directories-first @args }
function la { eza --color=auto --icons=auto --group-directories-first --all --git @args }
function ll { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }
function l { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }

# Key bindings
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

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

# fnm setup
fnm env --use-on-cd | Out-String | Invoke-Expression
fnm completions | Out-String | Invoke-Expression
