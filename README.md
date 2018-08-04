## DotFiles

These are my personal config files for my personal computer. If you want to use
some code, copy and paste in your own config. The install script is only for my
use. If you want to use the install script at least check thoroughly. Only you
will be responsible if your system breaks.

## Screenshot
![screenshot](screenshot.png "screenshot")

## Requirements

  * [ranger file manager](https://ranger.github.io/)
  * w3m-img(for Debian) or w3m (for Arch) (for preview\_images in ranger)
  * scrot (for lock.sh script)
  * imagemagick (for lock.sh script)
  * x11-xkb-utils
  * [nvim](https://neovim.io/)
  * [tmux](https://github.com/tmux/tmux/wiki)
  * cmus
  * xclip (for system clipboard integration in nvim)
  * i3wm or i3-gaps
  * i3blocks
  * feh
  * compton
  * sysstat (for cpu\_usage script in i3blocks)
  * acpi (for battery script in i3blocks)

## Install

    rm -rf ~/projects/dotFiles
    git clone https://www.github.com/enanajmain/dotFiles ~/projects
    cd ~/projects/dotFiles
    sh install.sh
    cd -
