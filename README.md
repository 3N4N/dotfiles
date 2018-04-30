## DotFiles

These are my personal config files for my personal computer. If you want to use
some code, copy and paste in your own config. The install script is only for my
use. If you want to use the install script at least check thoroughly. Only you
will be responsible if your system breaks.

## Requirements

  - [st-term](https://st.suckless.org) or [st-scroll_mouse](https://github.com/enanajmain/st-scroll_mouse)
  - w3m-img(for Debian) or w3m (for Arch)
  - [base16-shell](https://github.com/chriskempson/base16-shell)
  - scrot (for lock.sh script)
  - imagemagick (for lock.sh script)
  - x11-xkb-utils
  - compton
  - dunst
  - i3
  - i3blocks
  - sysstat (for cpu_usage script in i3blocks)
  - acpi (for battery script in i3blocks)
  - [neovim](https://neovim.io)
  - [ranger](https://ranger.github.io/)
  - [tmux](https://github.com/tmux/tmux/wiki)

### Install

    rm -rf ~/Git-repos/dotFiles
    git clone https://www.github.com/enanajmain/dotFiles ~/Git-repos
    cd ~/Git-repos/dotFiles/
    sh install.sh
    cd -
