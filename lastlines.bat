@echo off
REM ============================================================================
REM lastlines.cmd - List filename and last line of each matching file
REM
REM Usage: lastlines [file_glob]
REM   file_glob : Optional file pattern (e.g., *.txt, docs\*.*)
REM              Defaults to all files in current directory if not specified
REM ============================================================================
setlocal enabledelayedexpansion

set "file_glob=%~1"
if "%file_glob%"=="" set "file_glob=*"

for %%f in (%file_glob%) do (
    if not "%%f"=="%~nx0" (
        if exist "%%f" (
            set "lastline="
            for /f "delims=" %%l in ('type "%%f" 2^>nul') do set "lastline=%%l"
            echo %%~nxf: !lastline!
        )
    )
)

endlocal
