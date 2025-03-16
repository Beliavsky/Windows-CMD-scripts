@echo off
setlocal enabledelayedexpansion

REM Docstring
:: Compares files common to two directories using `fc`.
:: Usage: fcall.bat [dir1] dir2 [glob]
::   dir1 - First directory (optional, defaults to current directory).
::   dir2 - Second directory (required).
::   glob - File glob pattern (optional, defaults to *).
:: Compares matching files in dir1 and dir2 based on the glob pattern, outputs differences, and lists distinct files.

REM Initialize counters and distinct files list
set "same_count=0"
set "diff_count=0"
set "distinct_files="

REM Check if at least one argument is provided
if "%~1"=="" (
    echo Usage: %~nx0 [dir1] dir2 [glob]
    exit /b 1
)

REM Set dir1, dir2, and glob
set "dir1=."
set "glob=*"
if not "%~2"=="" (
    set "dir1=%~1"
    set "dir2=%~2"
    if not "%~3"=="" (
        set "glob=%~3"
    )
) else (
    set "dir2=%~1"
)

REM Ensure directories exist
if not exist "%dir1%" (
    echo Directory "%dir1%" does not exist.
    exit /b 1
)
if not exist "%dir2%" (
    echo Directory "%dir2%" does not exist.
    exit /b 1
)

REM Loop through files in dir1 matching the glob and compare with dir2
for %%f in ("%dir1%\%glob%") do (
    set "filename=%%~nxf"
    if exist "%dir2%\!filename!" (
        REM Perform comparison silently first to check for differences
        fc "%%f" "%dir2%\!filename!" >nul 2>&1
        if errorlevel 1 (
            REM If differences exist, run fc again to display them
            fc "%%f" "%dir2%\!filename!"
            set /a diff_count+=1
            set "distinct_files=!distinct_files! !filename!"
        ) else (
            set /a same_count+=1
        )
    )
)

REM Output results
echo # of Files that are the same: %same_count%
echo # of Files that are different: %diff_count%

REM Output distinct files
if not "!distinct_files!"=="" (
    echo Distinct files:
    for %%f in (!distinct_files!) do (
        echo %%f
    )
) else (
    echo No distinct files found.
)

exit /b
