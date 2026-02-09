@echo off
rem gitc.bat: group files matching a glob into NEW (not in HEAD), DIFFERENT (changed vs HEAD), and SAME (matches HEAD).
rem usage: gitc.bat "*.f90"

setlocal enabledelayedexpansion

if "%~1"=="" exit /b 2
set "pat=%~1"
set "cwd=%cd%\"

set "new="
set "diff="
set "same="
set "found=0"

for /f "delims=" %%F in ('dir /b /a-d /s "%pat%" 2^>nul') do (
  set "found=1"
  set "full=%%F"
  set "rel=!full:%cwd%=!"
  set "gitpath=!rel:\=/!"

  set "st="

  rem untracked => NEW
  git ls-files --error-unmatch -- "!gitpath!" >nul 2>nul
  if errorlevel 1 (
    set "new=!new! !rel!"
  ) else (
    rem tracked: check change vs HEAD; "A" means added relative to HEAD => NEW
    for /f "tokens=1" %%S in ('git diff --name-status HEAD -- "!gitpath!" 2^>nul') do set "st=%%S"

    if not defined st (
      set "same=!same! !rel!"
    ) else if /i "!st!"=="A" (
      set "new=!new! !rel!"
    ) else (
      set "diff=!diff! !rel!"
    )
  )
)

if "!found!"=="0" exit /b 1
if defined new  echo NEW!new!
if defined diff echo DIFFERENT!diff!
if defined same echo SAME!same!

endlocal
