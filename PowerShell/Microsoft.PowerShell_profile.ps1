# $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$dirSep = [IO.Path]::DirectorySeparatorChar

# ------- prompt ---------------------------------------------------------------

$esc = [char]27

Function prompt
{
    $loc = Get-Location
    Write-Host "$loc" -ForegroundColor "blue" -NoNewline
    $out = "> "
    if ($env:WT_SESSION) {
        if ($loc.Provider.Name -eq "FileSystem") {
            $out += "$([char]27)]9;9;`"$($loc.Path)`"$([char]7)"
        }
    }
    return $out
}

# ------- PSReadLine -----------------------------------------------------------

Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'`"-—―_"

Set-PSReadLineOption -PredictionSource None

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -chord ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -chord ctrl+n -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -chord alt+u -Function DowncaseWord
Set-PSReadLineKeyHandler -chord alt+o -Function UpcaseWord
Set-PSReadLineKeyHandler -chord alt+i -Function CapitalizeWord

Set-PSReadLineKeyHandler -chord ctrl+alt+u -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('cd ..')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineOption -Colors @{
  Command            = 'DarkYellow'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  InlinePrediction   = 'Gray'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}


# ------- fzf ------------------------------------------------------------------

# # --height 40% --multi
# $env:FZF_DEFAULT_OPTS='
# --layout=reverse --border
    # --bind ctrl-f:page-down,ctrl-b:page-up,?:toggle-preview
    # --color=light
    # --color=fg:-1,bg:-1,hl:33,fg+:241,bg+:221,hl+:33
    # --color=info:33,prompt:33,pointer:166,marker:166,spinner:33
# '

# if  hash ag 2>/dev/null ; then
#     SET FZF_DEFAULT_COMMAND='ag --nocolor -g "" 2> /dev/null'
#     SET FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# else
#     SET FZF_DEFAULT_COMMAND='find -type f'
#     SET FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fi


# ------- modules --------------------------------------------------------------

Import-Module posh-git


# ------- aliases --------------------------------------------------------------

if (Test-Path alias:ls) { Remove-Alias ls }
if (Test-Path alias:rm) { Remove-Alias rm }
if (Test-Path alias:rmdir) { Remove-Alias rmdir }
if (Test-Path alias:md) { Remove-Alias md }
if (Test-Path alias:mv) { Remove-Alias mv }
if (Test-Path alias:cp) { Remove-Alias cp }
if (Test-Path alias:r) { Remove-Alias r }
if (Test-Path alias:echo) { Remove-Alias echo }
if (Test-Path alias:where) { del alias:where -force }
if (Test-Path alias:sort) { del alias:sort -force }

Set-Alias -Name o -Value 'Start-Process'
Set-Alias -Name vi -Value 'nvim'
Set-Alias -Name md -Value 'C:/msys64/usr/bin/mkdir.exe'
Set-Alias -Name fd -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name du -Value 'C:/msys64/usr/bin/du.exe'
Set-Alias -Name find -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name tar -Value 'C:/msys64/usr/bin/tar.exe'
Set-Alias -Name mpv -Value 'C:/apps/mpv/mpv.exe'
Set-Alias -Name tig -Value 'C:\Program Files\Git\usr\bin\tig.exe'


Function l { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -1 @args }
Function ls { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhF @args }
Function ll { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhFl @args }
Function la { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhFlA @args }

Function gdb { & 'C:/msys64/mingw64/bin/gdb.exe' -q @args }
Function tree { & 'C:/msys64/usr/bin/tree.exe' -F @args }
Function wts { nvim "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json" }

Function Launch-VsDevShell
{
  & ${env:ProgramFiles(x86)}'/Microsoft Visual Studio/2019/Community/Common7/Tools/Launch-VsDevShell.ps1'
}

# Set-Alias -Name py -Value python
# Set-Alias -Name py2 -Value python2
# Set-Alias -Name py3 -Value python3
