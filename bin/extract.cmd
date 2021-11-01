@echo off

:: if not exist %1 (
::     echo %1 doesn't exist
::     exit /b 1
:: )

set filename=%1

if not x%filename%==x%filename:.tar.bz2=% (
    tar xvjf "%filename%"
) else if not x%filename%==x%filename:.tar.xz=% (
    7z x "%filename%"
    set tarfile=%filename:.tar.xz=.tar%
    tar xvf "%tarfile%"
) else if not x%filename%==x%filename:.tar.gz=% (
    tar xvzf "%filename%"
) else if not x%filename%==x%filename:.bz2=% (
    bunzip2 "%filename%"
) else if not x%filename%==x%filename:.rar=% (
    rar x "%filename%"
) else if not x%filename%==x%filename:.gz=% (
    gunzip "%filename%"
) else if not x%filename%==x%filename:.tar=% (
    tar xvf "%filename%"
) else if not x%filename%==x%filename:.tbz2=% (
    tar xvjf "%filename%"
) else if not x%filename%==x%filename:.tgz=% (
    tar xvzf "%filename%"
) else if not x%filename%==x%filename:.zip=% (
    unzip "%filename%"
) else if not x%filename%==x%filename:.Z=% (
    uncompress "%filename%"
) else if not x%filename%==x%filename:.xz=% (
    xz -d "%filename%"
) else if not x%filename%==x%filename:.7z=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.a=% (
    ar x "%filename%"
) else (
    echo "No uncompressing program found for this filetype."
)
