$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

# ------- prompt ---------------------------------------------------------------

$esc = [char]27

Function prompt
{
    $loc = Get-Location

    # Emulate standard PS prompt with location followed by ">"
    # $out = "PS $loc> "

    #Assign Windows Title Text
    $host.ui.rawui.windowtitle = $(if ($isInAdmin) {"ADMIN: "} $loc)

    #Configure current user and current folder
    $CmdPromptCurrentFolder = Split-Path -Path $pwd -Leaf
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();

    #Decorate the CMD Prompt
    Write-Host ""
    Write-Host "$($CmdPromptUser.Name.split("\")[1])@$env:COMPUTERNAME " -ForegroundColor DarkBlue -NoNewline

    If ($CmdPromptCurrentFolder -like "*:*") {
        Write-Host " $CmdPromptCurrentFolder "  -ForegroundColor Cyan
    }
    else {
        Write-Host "..\$CmdPromptCurrentFolder\ "  -ForegroundColor Cyan
    }

    if ($IsAdmin) {
        Write-Host "PS" -ForegroundColor DarkRed -NoNewline
    }
    else {
        Write-Host "PS" -ForegroundColor DarkGreen -NoNewline
    }

    $out = "> "

    # # Check for ConEmu existance and ANSI emulation enabled
    # if ($env:ConEmuANSI -eq "ON") {
    #     # Let ConEmu know when the prompt ends, to select typed
    #     # command properly with "Shift+Home", to change cursor
    #     # position in the prompt by simple mouse click, etc.
    #     $out += "$([char]27)]9;12$([char]7)"

    #     # And current working directory (FileSystem)
    #     # ConEmu may show full path or just current folder name
    #     # in the Tab label (check Tab templates)
    #     # Also this knowledge is crucial to process hyperlinks clicks
    #     # on files in the output from compilers and source control
    #     # systems (git, hg, ...)
    #     if ($loc.Provider.Name -eq "FileSystem") {
    #         $out += "$([char]27)]9;9;`"$($loc.Path)`"$([char]7)"
    #     }
    # }

    if ($env:WT_SESSION) {
        if ($loc.Provider.Name -eq "FileSystem") {
            $out += "$([char]27)]9;9;`"$($loc.Path)`"$([char]7)"
        }
    }

    return $out
}

# # https://gist.github.com/LuanVSO/6f2b94cf3bd90f184722676c43ccc1c6
# If($env:WT_SESSION){
# 	$prevprompt = $Function:prompt
# 	Function prompt {
# 		if ($pwd.provider.name -eq "FileSystem") {
# 			$p = $pwd.ProviderPath
# 			Write-Host "$esc]9;9;`"$p`"$esc\" -NoNewline
# 		}
# 		return $prevprompt.invoke()
# 	}
# }



# ------- PSReadLine -----------------------------------------------------------

Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None

Set-PSReadLineKeyHandler -chord ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -chord ctrl+n -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete


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


# ---------- Functions ---------------------------------------------------

Function Follow-Link([string]$sym)
{
    if (-Not (Test-Path -Path "$sym" -PathType Container)) {
        Write-Output "Directory doesn't exist or is a file."
    } else {
        cd "$(Get-Item "$sym" | Select-Object -ExpandProperty Target)"
    }
}
Set-Alias -Name cdl -Value Follow-Link
