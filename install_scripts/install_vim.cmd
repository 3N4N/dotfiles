@echo off

set VIMVER=90

rmdir /s /q vim%VIMVER%
mkdir vim%VIMVER%

xcopy /s  runtime\*         vim%VIMVER%
copy      src\vim.exe       vim%VIMVER%
copy      src\vimrun.exe    vim%VIMVER%
copy      src\tee\tee.exe   vim%VIMVER%
copy      src\xxd\xxd.exe   vim%VIMVER%
