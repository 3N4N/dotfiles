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

Set-PSReadLineKeyHandler -chord ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -chord ctrl+n -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function Complete


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


# ------- syntax highlighting --------------------------------------------------

Set-PSReadLineOption -Colors @{
  Command            = 'DarkYellow'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}


# ------- aliases --------------------------------------------------------------

if (Test-Path alias:ls) { Remove-Alias ls }
if (Test-Path alias:rm) { Remove-Alias rm }
if (Test-Path alias:rmdir) { Remove-Alias rmdir }
if (Test-Path alias:mv) { Remove-Alias mv }
if (Test-Path alias:r) { Remove-Alias r }
if (Test-Path alias:where) { del alias:where -force }
if (Test-Path alias:echo) { Remove-Alias echo }

Set-Alias -Name vi -Value nvim
Set-Alias -Name nvi -Value neovide

Set-Alias -Name find -Value 'C:\Program Files\git\usr\bin\find.exe'

# Set-Alias -Name py -Value python
# Set-Alias -Name py2 -Value python2
# Set-Alias -Name py3 -Value python3


# ------- Functions ------------------------------------------------------------

# Function ls-long { ls -NvhFl --group-directories-first --time-style=+ $args }
# Set-Alias -Name l -Value ls-long

# Function grep-color {
#     Param(
#           [Parameter(ValueFromPipeline=$true)]
#           [string[]]$text
#     )
#     Begin {}
#     Process {
#         grep --color --exclude-dir=".git" --exclude="tags" $text
#     }
#     End {}
# }
# Set-Alias -Name grep -Value grep-color

Function start-pwsh { Start-Process pwsh }
Set-Alias -Name stpw -Value start-pwsh

Function start-pwsh-admin { Start-Process pwsh -verb runas }
Set-Alias -Name stpwad -Value start-pwsh-admin

Function Follow-Link([string]$sym)
{
    if (-Not (Test-Path -Path "$sym" -PathType Container)) {
        Write-Output "Directory doesn't exist or is a file."
    } else {
        cd "$(Get-Item "$sym" | Select-Object -ExpandProperty Target)"
    }
}
Set-Alias -Name cdl -Value Follow-Link
