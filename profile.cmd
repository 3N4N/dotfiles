@echo off

PROMPT = $e]9;9;$p$e\$e[1;34m$p$e[1;0m$g$s

doskey ocmd = open cmd.exe $*
:: doskey dir = dir /OG $*
doskey cd = cd /d $*
doskey ns = nslookup $*
doskey ip = ipconfig $*
doskey vi = nvim $*
doskey grep = grep --color --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags" $*
doskey xclip = win32yank.exe $*
doskey psgrep = tasklist ^| grep --color -i $*
doskey o = open $*


:: commands for for docker
doskey dcbuild = docker-compose build
doskey dcup = docker-compose up
doskey dcdown = docker-compose down
doskey dockps = docker ps --format "{{.ID}}  {{.Names}}"
doskey docksh = docker exec -it $1 /bin/bash

:: import aliaes
doskey msys = C:\msys64\msys2_shell.cmd -defterm -here -no-start -msys
doskey m64 = C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw64
doskey m32 = C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw32

:: shortcuts to msys utilties
doskey l = "C:\Program Files\Git\usr\bin\ls" -NvhFl --group-directories-first --time-style=+ $*
doskey la = "C:\Program Files\Git\usr\bin\ls" -NvhFl --group-directories-first --time-style=+ -A $*
doskey mkdir = "C:\Program Files\Git\usr\bin\mkdir" -p $*
doskey tar = "C:\Program Files\Git\usr\bin\tar" $*
doskey gdb =  C:\msys64\mingw64\bin\gdb -q $*
doskey fd = C:\msys64\usr\bin\find $*
doskey tree = C:\msys64\usr\bin\tree $*
