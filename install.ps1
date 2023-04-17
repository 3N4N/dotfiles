$CURDIR=(Get-Location | Foreach-Object { $_.Path })

$PWSHDIR="$HOME/Documents/PowerShell"
$NVIMDIR="$HOME/AppData/Local/nvim"
$MPVDIR="$HOME/AppData/Roaming/mpv"
$GDBDIR="$HOME/.config/gdb"
$RDIR  ="$HOME/Documents"

if (-not (Test-Path -Path c:/bin -PathType Container)) {
    New-Item -Path c:/bin -ItemType "directory"
}
Remove-Item -Recurse -Force "C:/bin/extract.cmd"
New-Item -Type SymbolicLink -Path "C:/bin/extract.cmd" -Value $CURDIR/bin/extract.cmd

Remove-Item -Recurse -Force $PWSHDIR
New-Item -Type SymbolicLink -Path $PWSHDIR -Value $CURDIR/PowerShell

Remove-Item -Recurse -Force $NVIMDIR
New-Item -Type Junction -Path "$NVIMDIR" -Value $CURDIR/.config/nvim/

Remove-Item -Recurse -Force $MPVDIR
New-Item -Type Junction -Path "$MPVDIR" -Value $CURDIR/.config/mpv/

Remove-Item -Recurse -Force $GDBDIR
New-Item -Type Junction -Path "$GDBDIR" -Value $CURDIR/.config/gdb/

Remove-Item -Recurse -Force "$HOME/.sig"
New-Item -Type Junction -Path "$HOME/.sig" -Value $CURDIR/.sig/

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

Remove-Item -Recurse -Force $HOME/.ripgreprc
New-Item -Type SymbolicLink -Path "$HOME/.ripgreprc" -Value $CURDIR/.ripgreprc

Remove-Item -Recurse -Force $HOME/.tmux.conf
New-Item -Type SymbolicLink -Path "$HOME/.tmux.conf" -Value $CURDIR/.tmux.conf

Remove-Item -Recurse -Force $HOME/.uncrustify.cfg
New-Item -Type SymbolicLink -Path $HOME/.uncrustify.cfg -Value $CURDIR/.uncrustify.cfg

Remove-Item -Recurse -Force $RDIR/.Rprofile
New-Item -Type SymbolicLink -Path "$RDIR/.Rprofile" -Value $CURDIR/.Rprofile
