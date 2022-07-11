@echo off

PROMPT = $e]9;9;$p$e\$e[1;34m$p$e[1;0m$g$s

doskey o = start $*
doskey ocmd = start cmd.exe $*
doskey cd = cd /d $*
doskey ns = nslookup $*
doskey ip = ipconfig $*
doskey vi = nvim $*
doskey grep = grep --color --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags" $*
doskey xclip = win32yank.exe $*
doskey psgrep = tasklist ^| head -n 3 $T tasklist ^| grep --color -i $1
doskey wts = nvim "%LOCALAPPDATA%/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

doskey ffmpeg = ffmpeg -hide_banner $*
doskey ffplay = ffplay -hide_banner $*
doskey ffprobe = ffprobe -hide_banner $*


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
doskey vsdev = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64

:: shortcuts to msys utilties
doskey ls = "C:\Program Files\Git\usr\bin\ls" -NvhF --group-directories-first $*
doskey l = "C:\Program Files\Git\usr\bin\ls" -NvhFl --group-directories-first --time-style=+ $*
doskey la = "C:\Program Files\Git\usr\bin\ls" -NvhFl --group-directories-first --time-style=+ -A $*
doskey md = "C:\Program Files\Git\usr\bin\mkdir" -p $*
doskey tar = "C:\Program Files\Git\usr\bin\tar" $*
doskey gdb =  C:\msys64\mingw64\bin\gdb -q $*
doskey fd = C:\msys64\usr\bin\find $*
doskey tree = C:\msys64\usr\bin\tree -F $*
doskey echo = "C:/Program Files/Git/usr/bin/echo.exe" $*
doskey find = "C:/Program Files/Git/usr/bin/find.exe" $*
doskey du = "C:/Program Files/Git/usr/bin/du.exe" $*

doskey cmakec = cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 $*
doskey cmaked = cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug $*

set PATH=c:\msys64\mingw64\bin;c:\msys64\usr\bin;%PATH%
