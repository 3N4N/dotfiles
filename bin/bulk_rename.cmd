@rem Author:     Enan Ajmain
@rem Email:      3nan.ajmain@gmail.com
@rem Github:     3N4N


@echo off &setlocal
setlocal enabledelayedexpansion



set TMPFILE=%TMP%\bulk_rename.txt

if exist %TMPFILE% del %TMPFILE%

set /a OLDCNT=0
set /a n=0

@rem    Get the directories
for /d %%i in (*) do (
    call set "OLD=%%OLD%%;%%i\"
    set o[!OLDCNT!]=%%i\
    set /a OLDCNT=OLDCNT+1
    echo %%i\>> %TMPFILE%
)

@rem    Get the files
for %%i in (*) do (
    call set "OLD=%%OLD%%;%%i"
    set o[!OLDCNT!]=%%i
    set /a OLDCNT=OLDCNT+1
    echo %%i>> %TMPFILE%
)

@rem    Need to make it universal
@rem    Should use the command `open`
@rem    But I haven't set up nvim as the default editor
@rem    Don't know how
nvim %TMPFILE%

@rem    Get the renamed filenames
set /a NEWCNT=0
for /F "usebackq tokens=*" %%i in ("%TMPFILE%") do (
    call set "NEW=%%NEW%%;%%i"
    set n[!NEWCNT!]=%%i
    set /a NEWCNT=NEWCNT+1
)

@rem    If no file is deleted
@rem    Start renaming
@rem    I'll try to incorporate deleting at some point
@rem    But not today
if %OLDCNT% == %NEWCNT% (
    for /L %%i in (0,1,%OLDCNT%) do (
        if not %%i == %OLDCNT% (
            if not !o[%%i]! == !n[%%i]! (
                if !o[%%i]:~-1! == \ (
                    echo !o[%%i]! -^> !n[%%i]:~0,-1!
                    rename "!o[%%i]!" "!n[%%i]:~0,-1!"
                ) else (
                    echo !o[%%i]! -^> !n[%%i]!
                    rename "!o[%%i]!" "!n[%%i]!"
                )
            )
        )
    )
)
