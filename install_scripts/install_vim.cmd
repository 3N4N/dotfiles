@echo off

rmdir /s /q vim
mkdir vim

xcopy /s runtime\* vim
copy src\*.exe vim
copy src\tee\tee.exe vim
copy src\xxd\xxd.exe vim

rmdir /s /q C:\apps\vim
mkdir C:\apps\vim
xcopy /s vim C:\apps\vim
