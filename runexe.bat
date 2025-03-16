@echo off
:: runs all .exe files in the current directory,
:: reports any that encounter runtime errors, and summarizes the results.
setlocal enabledelayedexpansion

set ERROR_COUNT=0
set SUCCESS_COUNT=0
set "ERROR_LIST="

echo Running all .exe files in the current directory...
echo.

for %%f in (*.exe) do (
    echo Running %%f...
    %%f
    if errorlevel 1 (
        echo [ERROR] %%f encountered a runtime error.
        set /a ERROR_COUNT+=1
        set "ERROR_LIST=!ERROR_LIST! %%f"
    ) else (
        echo [SUCCESS] %%f ran successfully.
        set /a SUCCESS_COUNT+=1
    )
    echo.
)

echo.
echo Summary:
echo ========
echo Executables with runtime errors: %ERROR_COUNT%
echo Executables without runtime errors: %SUCCESS_COUNT%
echo.
if not "!ERROR_LIST!"=="" (
    echo The following executables had runtime errors:
    echo !ERROR_LIST!
)
echo.

endlocal
