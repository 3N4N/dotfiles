@echo off

PROMPT = $e]9;9;$p$e\$e[1;34m$p$e[1;0m$+$g$s

:: aliases
doskey o = start "" $*
doskey ns = nslookup $*
doskey ip = ipconfig $*
doskey vi = nvim $*
doskey vim = vimd $*
doskey grep = grep --color --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags" $*
doskey egrep = grep --color --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags" -E $*
doskey xclip = win32yank.exe $*
doskey wts = nvim "%LOCALAPPDATA%/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
doskey myip = curl -s https://icanhazip.com

:: tasks
doskey ps = tasklist $*
doskey psgrep = tasklist ^| head -n 3 $T tasklist ^| grep --color -i $1
doskey kill = taskkill $*

:: ffmpeg
doskey ffmpeg = ffmpeg -hide_banner $*
doskey ffplay = ffplay -hide_banner $*
doskey ffprobe = ffprobe -hide_banner $*

:: docker
doskey dcbuild = docker-compose build
doskey dcup = docker-compose up
doskey dcdown = docker-compose down
doskey dockps = docker ps --format "{{.ID}}  {{.Names}}"
doskey docksh = docker exec -it $1 /bin/bash

:: import aliaes
doskey msys = C:\msys64\msys2_shell.cmd -defterm -here -no-start -msys
doskey m64 = C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw64
doskey m32 = C:\msys64\msys2_shell.cmd -defterm -here -no-start -mingw32
doskey vsdev = C:\PROGRA~2\MICROS~2\2019\Community\Common7\Tools\VsDevCmd.bat -arch=x64 -host_arch=x64

:: msys tools
doskey ls = "C:/msys64/usr/bin/ls" -NvhF --group-directories-first $*
doskey l = "C:/msys64/usr/bin/ls" -NvhFl --group-directories-first --time-style=+ $*
doskey la = "C:/msys64/usr/bin/ls" -NvhFl --group-directories-first --time-style=+ -A $*
doskey md = "C:/msys64/usr/bin/mkdir" -p $*
doskey tar = "C:/msys64/usr/bin/tar" $*
doskey gdb =  "C:/msys64/mingw64/bin/gdb" -q $*
doskey fd = "C:/msys64/usr/bin/find" $*
doskey tree = "C:/msys64/usr/bin/tree" -F $*
doskey echo = "C:/msys64/usr/bin/echo.exe" $*
doskey find = "C:/msys64/usr/bin/find.exe" $*
doskey du = "C:/msys64/usr/bin/du.exe" $*
doskey mpv = "C:/apps/mpv/mpv.exe" $*

:: cmake
doskey cmake = "c:/msys64/mingw64/bin/cmake.exe" $*
doskey cmakec = "c:/msys64/mingw64/bin/cmake.exe" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 $*
doskey cmaked = "c:/msys64/mingw64/bin/cmake.exe" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug $*

:: prepend to PATH
set PATH=c:\msys64\mingw64\bin;c:\msys64\usr\bin;%PATH%
