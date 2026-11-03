# Emergix Academy - Local Launcher Script (PowerShell)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$ScriptDir\artifacts\oscepass"

$env:API_PROXY_TARGET = "https://emergix-academy--keshomid89.replit.app"
$env:PORT = "5173"

Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "  Emergix Academy - Starting Local Dev Server" -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "  Frontend URL: http://localhost:5173" -ForegroundColor Yellow
Write-Host "  API Backend:  $env:API_PROXY_TARGET" -ForegroundColor Gray
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

npx vite --port 5173 --host 0.0.0.0
