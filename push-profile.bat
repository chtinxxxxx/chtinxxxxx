@echo off
setlocal enabledelayedexpansion
title Christine Nilo - Push GitHub Profile
color 0B

echo ========================================================
echo    Christine Nilo - GitHub Profile README Push
echo ========================================================
echo.

:: 1. Navigate to the profile repository directory
cd /d "%~dp0"
if not exist "README.md" (
    if exist "chtinxxxxx-github-profile\README.md" (
        cd /d "%~dp0chtinxxxxx-github-profile"
    ) else (
        color 0C
        echo [ERROR] Could not find the chtinxxxxx-github-profile folder.
        echo.
        pause
        exit /b 1
    )
)

:: 2. Check if git is installed
where git >nul 2>&1
if %ERRORLEVEL% neq 0 (
    color 0C
    echo [ERROR] Git is not installed or not in PATH.
    echo.
    pause
    exit /b 1
)

:: 3. Target repository check
set "REMOTE_URL=https://github.com/chtinxxxxx/chtinxxxxx.git"
git remote remove origin >nul 2>&1
git remote add origin !REMOTE_URL!

echo Target GitHub Profile Repository:
echo   !REMOTE_URL!
echo.
echo NOTE: GitHub requires this repository to be named EXACTLY:
echo       chtinxxxxx
echo so it appears on your public profile (https://github.com/chtinxxxxx).
echo.
echo If you have NOT created this repository on GitHub yet:
echo   1. Go to: https://github.com/new
echo   2. Repository name: chtinxxxxx
echo   3. Leave it Public, do NOT check Add a README
echo   4. Click 'Create repository'
echo.
echo Press ENTER when you are ready to push...
pause >nul

:: 4. Ensure branch is main
git branch -M main

:: 5. Stage and commit
echo.
echo Staging profile assets and README...
git add .
git diff --cached --quiet
if %ERRORLEVEL% neq 0 (
    git commit -m "Update Christine Nilo GitHub Profile README"
)

:: 6. Push to GitHub
echo.
echo ========================================================
echo Pushing profile to https://github.com/chtinxxxxx/chtinxxxxx ...
echo ========================================================
echo.

git push -u origin main

if %ERRORLEVEL% equ 0 (
    color 0A
    echo.
    echo ========================================================
    echo   [SUCCESS] Profile README pushed to GitHub!
    echo ========================================================
    echo.
    echo Your GitHub Profile is now LIVE!
    echo Open your profile to see your swimming pool banner & bio:
    echo   👉 https://github.com/chtinxxxxx
    echo.
) else (
    color 0E
    echo.
    echo [Notice] Push did not complete directly. Trying to reconcile if repo was created with a file...
    git pull origin main --rebase --autostash >nul 2>&1
    git push -u origin main
    if !ERRORLEVEL! equ 0 (
        color 0A
        echo.
        echo ========================================================
        echo   [SUCCESS] Profile README pushed to GitHub!
        echo ========================================================
        echo.
        echo Your GitHub Profile is now LIVE!
        echo   👉 https://github.com/chtinxxxxx
        echo.
    ) else (
        color 0C
        echo.
        echo ========================================================
        echo   [FAILED] Could not push to chtinxxxxx.
        echo ========================================================
        echo.
        echo Please ensure:
        echo   1. You created the repository named 'chtinxxxxx' at: https://github.com/new
        echo   2. It is set to 'Public'.
        echo.
    )
)

pause
