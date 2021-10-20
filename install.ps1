$CURDIR=(Get-Location | Foreach-Object { $_.Path })

$VIMDIR="$HOME/AppData/Local/nvim"
$MPVDIR="$HOME/AppData/Roaming/mpv"
$GDBDIR="$HOME/.config/gdb"

if (-not (Test-Path -Path c:/bin -PathType Container)) {
    New-Item -Path c:/bin -ItemType "directory"
}
New-Item -Type SymbolicLink -Path "C:/bin/extract.cmd" -Value $CURDIR/bin/extract.cmd

Remove-Item -Recurse -Force $PROFILE
New-Item -Type SymbolicLink -Path $PROFILE -Value $CURDIR/Microsoft.PowerShell_profile.ps1

Remove-Item -Recurse -Force $VIMDIR
New-Item -Type Junction -Path "$VIMDIR" -Value $CURDIR/.config/nvim/

Remove-Item -Recurse -Force $MPVDIR
New-Item -Type Junction -Path "$MPVDIR" -Value $CURDIR/.config/mpv/

Remove-Item -Recurse -Force $GDBDIR
New-Item -Type Junction -Path "$GDBDIR" -Value $CURDIR/.config/gdb/

Remove-Item -Recurse -Force $HOME/.inputrc
New-Item -Type SymbolicLink -Path "$HOME/.inputrc" -Value $CURDIR/.inputrc

Remove-Item -Recurse -Force $HOME/.bashrc
New-Item -Type SymbolicLink -Path "$HOME/.bashrc" -Value $CURDIR/.bashrc

Remove-Item -Recurse -Force $HOME/.bash_profile
New-Item -Type SymbolicLink -Path "$HOME/.bash_profile" -Value $CURDIR/.bash_profile

Remove-Item -Recurse -Force $HOME/.profile
New-Item -Type SymbolicLink -Path "$HOME/.profile" -Value $CURDIR/.profile

Remove-Item -Recurse -Force $HOME/.gitconfig
New-Item -Type SymbolicLink -Path "$HOME/.gitconfig" -Value $CURDIR/.gitconfig

Remove-Item -Recurse -Force $HOME/.tmux.conf
New-Item -Type SymbolicLink -Path "$HOME/.tmux.conf" -Value $CURDIR/.tmux.conf
