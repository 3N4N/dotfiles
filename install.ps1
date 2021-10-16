$CURDIR=(Get-Location | Foreach-Object { $_.Path })

$VIMDIR="$HOME/AppData/Local/nvim"
$MPVDIR="$HOME/AppData/Roaming/mpv"
$GDBDIR="$HOME/.config/gdb"

if (-Not(Test-Path -Path $PROFILE)) {
    New-Item -Type SymbolicLink -Path $PROFILE -Value $CURDIR/Microsoft.PowerShell_profile.ps1
}

if (-Not(Test-Path -Path "$VIMDIR")) {
    New-Item -Type Junction -Path "$VIMDIR" -Value $CURDIR/.config/nvim/
}

if (-Not(Test-Path -Path "$MPVDIR")) {
    New-Item -Type Junction -Path "$MPVDIR" -Value $CURDIR/.config/mpv/
}

if (-Not(Test-Path -Path "$GDBDIR")) {
    New-Item -Type Junction -Path "$GDBDIR" -Value $CURDIR/.config/gdb/
}

if (-Not(Test-Path -Path "~/.inputrc")) {
    New-Item -Type SymbolicLink -Path "~/.inputrc" -Value $CURDIR/.inputrc
}

if (-Not(Test-Path -Path "~/.bashrc")) {
    New-Item -Type SymbolicLink -Path "~/.bashrc" -Value $CURDIR/.bashrc
}

if (-Not(Test-Path -Path "~/.bash_profile")) {
    New-Item -Type SymbolicLink -Path "~/.bash_profile" -Value $CURDIR/.bash_profile
}

if (-Not(Test-Path -Path "~/.profile")) {
    New-Item -Type SymbolicLink -Path "~/.profile" -Value $CURDIR/.profile
}

if (-Not(Test-Path -Path "~/.gitconfig")) {
    New-Item -Type SymbolicLink -Path "~/.gitconfig" -Value $CURDIR/.gitconfig
}

if (-Not(Test-Path -Path "~/.tmux.conf")) {
    New-Item -Type SymbolicLink -Path "~/.tmux.conf" -Value $CURDIR/.tmux.conf
}
