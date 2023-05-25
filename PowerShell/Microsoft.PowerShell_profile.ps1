# -- title -------------------------------------------------------------------

# $host.ui.RawUI.WindowTitle = 'PowerShell'


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
Set-PSReadlineOption -WordDelimiters "?;:,.[]{}()/\|^&*-=+'`"-—―_"

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


# -- aliases -----------------------------------------------------------------

Remove-Alias -Force -ErrorAction SilentlyContinue `
    ls,rm,rmdir,md,mv,cp,r,where,sort,man,tee

Set-Alias -Name im -Value Import-Module

Set-Alias -Name o -Value 'Start-Process'
Set-Alias -Name vi -Value 'nvim'
Set-Alias -Name mpv -Value 'C:/apps/mpv/mpv.exe'
Set-Alias -Name git -Value 'C:/Users/ACER/scoop/shims/git.exe'
Set-Alias -Name xclip -Value 'win32yank'

Set-Alias -Name cp -Value 'C:/msys64/usr/bin/cp.exe'
Set-Alias -Name du -Value 'C:/msys64/usr/bin/du.exe'
Set-Alias -Name fd -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name file -Value 'C:/msys64/usr/bin/file.exe'
Set-Alias -Name find -Value 'C:/msys64/usr/bin/find.exe'
Set-Alias -Name grep -Value 'C:/msys64/usr/bin/grep.exe'
Set-Alias -Name head -Value 'C:/msys64/usr/bin/head.exe'
Set-Alias -Name less -Value 'C:/msys64/usr/bin/less.exe'
Set-Alias -Name md -Value 'C:/msys64/usr/bin/mkdir.exe'
Set-Alias -Name rm -Value 'C:/msys64/usr/bin/rm.exe'
Set-Alias -Name tail -Value 'C:/msys64/usr/bin/tail.exe'
Set-Alias -Name tar -Value 'C:/msys64/usr/bin/tar.exe'
Set-Alias -Name tree -Value 'C:/msys64/usr/bin/tree.exe'

Set-Alias -Name ls -Value Get-ChildItem
Function l { & 'C:/msys64/usr/bin/ls' --group-directories-first --time-style=+ -NvhFl @args }
Function la { & 'C:/msys64/usr/bin/ls' --group-directories-first --time-style=+ -NvhFlA @args }
Function mcd { mkdir @args; cd @args }

Function gdb { & 'C:/msys64/ucrt64/bin/gdb.exe' -q @args }

Function wts { nvim "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json" }
Function rg { rg.exe --smart-case @args } # w/o .exe, it'll hang, cause recursive
function Licensify { curl -s -S https://www.gnu.org/licenses/gpl-3.0.txt > COPYING }

Function msys { & C:\msys64\msys2_shell.cmd -defterm -here -no-start @args }
Function ucrt { msys -ucrt64 }

Set-Alias -Name cmake -Value 'C:/msys64/ucrt64/bin/cmake.exe'
function cmakec { cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 @args }
function cmaked { cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug @args }

function clang { C:/msys64/ucrt64/bin/clang.exe -fno-diagnostics-color @args }
function clang++ { C:/msys64/ucrt64/bin/clang++.exe -fno-diagnostics-color @args }

# -- Functions ---------------------------------------------------------------

Function Get-Process-Custom
{
  param ([string]$ProcName)
  if ($ProcName.Length -eq 0) {
    Get-Process | less
    return
  }
  Get-Process $ProcName | Select Id, Name, Commandline | Format-Table -Wrap
}
Set-Alias -Name ps -Value Get-Process-Custom

Function Launch-VsDevShell
{
  & C:\PROGRA~1\MICROS~3\2022\Community\Common7\Tools\Launch-VsDevShell.ps1 `
    -SkipAutomaticLocation @args
  [Environment]::SetEnvironmentVariable(
      "Path",
      ($env:Path.Split(';') `
       | Where-Object { $_ -ne 'c:\msys64\ucrt64\bin' } `
       | Where-Object { $_ -ne 'c:\msys64\usr\bin' } ) -join ';'
  )
}


# -- ENV ---------------------------------------------------------------------

[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
[Environment]::SetEnvironmentVariable("Path",   "c:/msys64/ucrt64/bin;c:/msys64/usr/bin;" + $env:Path)
[Environment]::SetEnvironmentVariable("TERM",   "xterm-256color")
[Environment]::SetEnvironmentVariable("CC",     "clang")
[Environment]::SetEnvironmentVariable("CXX",    "clang++")
[Environment]::SetEnvironmentVariable("RIPGREP_CONFIG_PATH", "$HOME/.ripgreprc")
