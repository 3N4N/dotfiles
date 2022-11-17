# -- title -------------------------------------------------------------------

$host.ui.RawUI.WindowTitle = 'PowerShell'


# -- prompt ------------------------------------------------------------------

$ESC = [char]27

# disable python venv auto prompt
$env:VIRTUAL_ENV_DISABLE_PROMPT = 0

Function prompt
{
  # prepend python venv info when enabled
  if (($env:VIRTUAL_ENV_DISABLE_PROMPT) -and ($env:VIRTUAL_ENV -ne $null)) {
    Write-Host "($( Split-Path $env:VIRTUAL_ENV -Leaf )) " -ForegroundColor "green" -NoNewline
  }

  $loc = $executionContext.SessionState.Path.CurrentLocation
  $out = ""

  # OSC codes for opening splits in current directory
  if ($loc.Provider.Name -eq "FileSystem") {
    if ($env:WT_SESSION) {
      $out += "$ESC]9;9;`"$($loc.Path)`"${ESC}\"
    }
    elseif ($env:TERM_PROGRAM -eq 'WezTerm') {
      if ($loc.Provider.Name -eq "FileSystem") {
        $provider_path = $loc.ProviderPath -Replace "\\", "/"
        $out = "$ESC]7;file://${env:COMPUTERNAME}/${provider_path}${ESC}\"
      }
    }
  }

  Write-Host "$loc" -ForegroundColor "blue" -NoNewline
  return "${out}$('>' * ($nestedPromptLevel + 1)) ";
}

# -- modules -----------------------------------------------------------------

# Import-Module posh-git


# -- PSReadLine --------------------------------------------------------------

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
  Command            = [ConsoleColor]::Black
  Number             = [ConsoleColor]::Black
  Member             = [ConsoleColor]::Black
  Operator           = [ConsoleColor]::Black
  Type               = [ConsoleColor]::Black
  Variable           = [ConsoleColor]::Black
  Parameter          = [ConsoleColor]::Black
  InlinePrediction   = [ConsoleColor]::Black
  ContinuationPrompt = [ConsoleColor]::Black
  Default            = [ConsoleColor]::Black
}


# -- fzf ---------------------------------------------------------------------

# # --height 40% --multi
# $env:FZF_DEFAULT_OPTS='
# --layout=reverse --border
#     --bind ctrl-f:page-down,ctrl-b:page-up,?:toggle-preview
#     --color=light
#     --color=fg:-1,bg:-1,hl:33,fg+:241,bg+:221,hl+:33
#     --color=info:33,prompt:33,pointer:166,marker:166,spinner:33
# '

# if  hash ag 2>/dev/null ; then
#     SET FZF_DEFAULT_COMMAND='ag --nocolor -g "" 2> /dev/null'
#     SET FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# else
#     SET FZF_DEFAULT_COMMAND='find -type f'
#     SET FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fi



# -- aliases -----------------------------------------------------------------

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

Set-Alias -Name im -Value Import-Module

Set-Alias -Name o -Value 'Start-Process'
Set-Alias -Name vi -Value 'nvim'
Set-Alias -Name md -Value 'C:/msys64/usr/bin/mkdir.exe'
Set-Alias -Name fd -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name du -Value 'C:/msys64/usr/bin/du.exe'
Set-Alias -Name find -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name tar -Value 'C:/msys64/usr/bin/tar.exe'
Set-Alias -Name mpv -Value 'C:/apps/mpv/mpv.exe'
Set-Alias -Name git -Value 'C:/Users/ACER/scoop/shims/git.exe'

Set-Alias -Name ls -Value Get-ChildItem
Function l { & 'C:/msys64/usr/bin/ls' --group-directories-first --time-style=+ -NvhFl @args }
Function la { & 'C:/msys64/usr/bin/ls' --group-directories-first --time-style=+ -NvhFlA @args }

Function gdb { & 'C:/msys64/mingw64/bin/gdb.exe' -q @args }
Function tree { & 'C:/msys64/usr/bin/tree.exe' -F @args }
Function wts { nvim "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json" }
Function rg { rg.exe --smart-case @args } # w/o .exe, it'll hang, cause recursive

Function msys { & C:\msys64\msys2_shell.cmd -defterm -here -no-start -msys }
Function m64 { & C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw64 }
Function m32 { & C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw32 }
Function vsdev { & C:\PROGRA~2\MICROS~2\2019\Community\Common7\Tools\VsDevCmd.bat -arch=x64 -host_arch=x64 }

Set-Alias -Name cmake -Value 'C:/msys64/mingw64/bin/cmake.exe'
function cmakec { & "C:/msys64/mingw64/bin/cmake.exe" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 @args }
function cmaked { & "C:/msys64/mingw64/bin/cmake.exe" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug @args }

function Licensify { curl -s -S https://www.gnu.org/licenses/gpl-3.0.txt > COPYING }

Function Launch-VsDevShell
{
  [Environment]::SetEnvironmentVariable(
      "Path",
      ($env:Path.Split(';') `
       | Where-Object { $_ -ne 'c:\msys64\mingw64\bin' } `
       | Where-Object { $_ -ne 'c:\msys64\usr\bin' } ) -join ';'
  )
  & ${env:ProgramFiles(x86)}'/Microsoft Visual Studio/2019/Community/Common7/Tools/Launch-VsDevShell.ps1'
}

[Environment]::SetEnvironmentVariable("Path", "c:\msys64\mingw64\bin;c:\msys64\usr\bin;" + $env:Path)
