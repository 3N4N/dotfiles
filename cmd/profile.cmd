@echo off

PROMPT = $e]9;9;$p$e\$e[0;34m$p$e[1;0m$+$g$s

doskey /macrofile=E:\projects\dotfiles\cmd\macinit

set CLINK_TERM_VE=\e[0 q\e[?12l
set RIPGREP_CONFIG_PATH=%USERPROFILE%\.ripgreprc
set LESS=-iSMRF
set VISUAL=vim

REM prepend to PATH
set PATH=%PATH%;%USERPROFILE%\scoop\apps\git\current\usr\bin;C:\mingw64\bin
