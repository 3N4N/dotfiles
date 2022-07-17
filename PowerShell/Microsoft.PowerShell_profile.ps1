# $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$dirSep = [IO.Path]::DirectorySeparatorChar

# ------- prompt ---------------------------------------------------------------

$esc = [char]27

Function prompt
{
    $loc = Get-Location

    #Assign Windows Title Text
    $host.ui.rawui.windowtitle = $(if ($isInAdmin) {"ADMIN: "} $loc)

    # $promptloc = -Join(($loc | Split-Path -Qualifier),
    #                    $dirSep, ($loc | Split-Path | Split-Path -Leaf),
    #                    $dirSep, ($loc | Split-Path -Leaf))

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
if (Test-Path alias:mv) { Remove-Alias mv }
if (Test-Path alias:r) { Remove-Alias r }
if (Test-Path alias:where) { del alias:where -force }
if (Test-Path alias:echo) { Remove-Alias echo }

Set-Alias -Name vi -Value 'C:\apps\nvim\bin\nvim.exe'
Set-Alias -Name find -Value 'c:\msys64\usr\bin\find.exe'

Function l { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -1 @args }
Function ls { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhF @args }
Function ll { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhFl @args }
Function la { & 'C:/Program Files/Git/usr/bin/ls' --group-directories-first --time-style=+ -NvhFlA @args }

Function gdb { & 'C:\msys64\mingw64\bin\gdb' -q @args }
Function tree { & 'C:\msys64\mingw64\bin\tree' -F @args }

Set-Alias -Name tar -Value 'C:\msys64\usr\bin\tar.exe'
Set-Alias -Name fd -Value 'C:\msys64\usr\bin\find'
Set-Alias -Name du -Value 'C:\msys64\usr\bin\du.exe'
Set-Alias -Name mpv -Value 'C:/apps/mpv/mpv.exe'

# Set-Alias -Name py -Value python
# Set-Alias -Name py2 -Value python2
# Set-Alias -Name py3 -Value python3
