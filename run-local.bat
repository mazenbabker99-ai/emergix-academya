@echo off
title Emergix Academy - Local Server
echo ===================================================
echo   Emergix Academy - Starting Local Dev Server
echo ===================================================
echo.
cd /d "%~dp0\artifacts\oscepass"
set API_PROXY_TARGET=https://emergix-academy--keshomid89.replit.app
set PORT=5173

echo [1/2] Connecting local frontend to live backend...
echo Target API: %API_PROXY_TARGET%
echo.
echo [2/2] Opening server on http://localhost:5173 ...
echo.
call npx vite --port 5173 --host 0.0.0.0
pause
