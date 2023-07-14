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
Set-Alias -Name vi -Value 'vim'
Set-Alias -Name mpv -Value 'C:/apps/mpv/mpv.exe'
Set-Alias -Name xclip -Value 'win32yank'

# Set-Alias -Name ls -Value Get-ChildItem
Function l { ls --group-directories-first -vhFl @args }
Function la { ls --group-directories-first -vhFlA @args }
Function mcd { New-Item -Type Directory @args; Set-Location @args }
Function dots { Set-Location E:/projects/dotfiles/ }

function wts { vi "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json" }
function rg { rg.exe --smart-case @args } # w/o .exe, it'll hang, cause recursive
Function msys { & C:/msys64/msys2_shell.cmd -defterm -here -no-start -full-path @args }
function Licensify { curl -s -S https://www.gnu.org/licenses/gpl-3.0.txt > COPYING }

function cmakec { cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 @args }
function cmaked { cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug @args }

# -- Functions ---------------------------------------------------------------

Function Get-Process-Custom
{
  param ([string]$ProcName)
  if ($ProcName.Length -eq 0) {
    # FIXME: check if 'less' exists
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
$env:TERM = "xterm-256color"
$env:VISUAL = "vim"
$env:LESS = "-iSMRF"
$env:RIPGREP_CONFIG_PATH = "$HOME\.ripgreprc"

$env:Path = (
    @(
        $env:USERPROFILE + '\scoop\shims'
        $env:USERPROFILE + '\scoop\apps\git\current\usr\bin'
        'C:\mingw64\bin'
        # 'C:\msys64\ucrt64\bin;C:\msys64\usr\bin'
        $env:Path.Split(';')
     ) | Select-Object -Unique
) -join ';'


# -- Misc --------------------------------------------------------------------

Write-Output "$ESC[2 q"               # for xterm-like terms: unblinking block cursor
