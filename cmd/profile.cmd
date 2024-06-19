@echo off

PROMPT = $e]9;9;$p$e\$e[0;34m$p$e[1;0m$+$g$s

doskey /macrofile=E:\projects\dotfiles\cmd\macinit

set CLINK_TERM_VE=\e[0 q\e[?12l
set GCC_COLORS=error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=35:quote=30:path=01;36:fixit-insert=32:fixit-delete=31:diff-filename=35:diff-hunk=32:diff-delete=31:diff-insert=32:type-diff=01;32:fnname=35;32:targs=35
set RIPGREP_CONFIG_PATH=%USERPROFILE%\.ripgreprc
set LESS=-iSMRF
set VISUAL=vim

REM prepend to PATH
set PATH=%PATH%;%PROGRAMFILES%\Git\usr\bin;C:\mingw64\bin
