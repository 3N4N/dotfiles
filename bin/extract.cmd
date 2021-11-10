@echo off

set filename=%1

if not x%filename%==x%filename:.tar.bz2=% (
    7z x "%filename%" -so | 7z x -aoa -si -ttar
) else if not x%filename%==x%filename:.tar.xz=% (
    7z x "%filename%" -so | 7z x -aoa -si -ttar
) else if not x%filename%==x%filename:.tar.gz=% (
    7z x "%filename%" -so | 7z x -aoa -si -ttar
) else if not x%filename%==x%filename:.bz2=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.rar=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.gz=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.tar=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.tbz2=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.tgz=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.zip=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.Z=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.xz=% (
    7z x "%filename%"
) else if not x%filename%==x%filename:.7z=% (
    7z x "%filename%"
) else (
    echo "No uncompressing program found for this filetype."
)
