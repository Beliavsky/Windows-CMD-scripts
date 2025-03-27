@echo off
REM This script renames a file (passed as %1) to a version without spaces, commas, or extra hyphens in its name.
REM Usage: rename_no_spaces.bat "file, with spaces.ext"

REM Check if a file argument was provided
if "%~1"=="" (
    echo Usage: %~nx0 "file_with_spaces.ext"
    exit /b 1
)

REM Extract the file path, name, and extension
set "filepath=%~dp1"
set "filename=%~n1"
set "extension=%~x1"

REM Replace spaces in the filename with underscores
set "newname=%filename: =_%"

REM Replace commas with underscores
set "newname=%newname:,=_%"

REM Replace hyphens with underscores
set "newname=%newname:-=_%"

REM Remove consecutive underscores
:remove_extra_underscores
set "tempname=%newname:__=_%"
if "%tempname%" neq "%newname%" (
    set "newname=%tempname%"
    goto remove_extra_underscores
)

REM Rename the file
rename "%~1" "%newname%%extension%"

REM Inform the user
echo Renamed "%~1" to "%newname%%extension%"
