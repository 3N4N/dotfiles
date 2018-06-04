## DotFiles

These are my personal config files for my personal computer. If you want to use
some code, copy and paste in your own config. The install script is only for my
use. If you want to use the install script at least check thoroughly. Only you
will be responsible if your system breaks.

## Requirements

  * [st-term](https://st.suckless.org) or [st-scroll\_mouse](https://github.com/enanajmain/st-scroll_mouse)
  * w3m-img(for Debian) or w3m (for Arch) (for preview\_images in ranger)
  * [base16-shell](https://github.com/chriskempson/base16-shell)
  * scrot (for lock.sh script)
  * imagemagick (for lock.sh script)
  * x11-xkb-utils
  * xclip
  * compton
  * sysstat (for cpu\_usage script in i3blocks)
  * acpi (for battery script in i3blocks)

### Install

    rm -rf ~/projects/dotFiles
    git clone https://www.github.com/enanajmain/dotFiles ~/projects
    cd ~/projects/dotFiles
    sh install.sh
    cd -
