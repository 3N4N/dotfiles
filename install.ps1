$CURDIR=(Get-Location | Foreach-Object { $_.Path })

$VIMDIR="$HOME/AppData/Local/nvim"
$MPVDIR="$HOME/AppData/Roaming/mpv"

if (-Not(Test-Path -Path $PROFILE)) {
    New-Item -Type SymbolicLink -Path $PROFILE -Value $CURDIR/Microsoft.PowerShell_profile.ps1
}

if (-Not(Test-Path -Path "$VIMDIR")) {
    New-Item -Type Junction -Path "$VIMDIR" -Value $CURDIR/.config/nvim/
}

if (-Not(Test-Path -Path "$MPVDIR")) {
    New-Item -Type Junction -Path "$MPVDIR" -Value $CURDIR/.config/mpv/
}
