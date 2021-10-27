@echo off

PROMPT=$e]9;9;$p$e\$e[1;34m$p$e[1;0m$g$s

doskey ocmd=open cmd.exe $*
doskey dir=dir /OG $*
doskey ns=nslookup $*
doskey ip=ipconfig $*
doskey vi=nvim $*
doskey grep=grep --color --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags" $*
doskey xclip=win32yank.exe $*
doskey psgrep=tasklist ^| grep --color -i $*
doskey e=explorer $*

:: useful ls aliases
doskey l=ls -NvhFl --group-directories-first $*
doskey la=ls -NvhFl --group-directories-first -A $*

:: commands for for docker
doskey dcbuild=docker-compose build
doskey dcup=docker-compose up
doskey dcdown=docker-compose down
doskey dockps=docker ps --format "{{.ID}}  {{.Names}}"
:: docksh() { docker exec -it $1 /bin/bash; }
