@echo off
REM Vercel Deployment Helper Script for Windows
REM This script helps you deploy your Intern Management System to Vercel

echo ==================================
echo Vercel Deployment Helper
echo ==================================
echo.

REM Check if running from project root
if not exist "frontend\" (
    echo Error: Please run this script from the project root directory
    exit /b 1
)
if not exist "backend\" (
    echo Error: Please run this script from the project root directory
    exit /b 1
)

echo Deployment Checklist:
echo.
echo 1. Backend Deployment (Choose one):
echo    [ ] Railway: https://railway.app
echo    [ ] Render: https://render.com
echo    [ ] Heroku: https://heroku.com
echo.
echo 2. Database Setup:
echo    [ ] PostgreSQL instance created
echo    [ ] Schema and seed data loaded
echo    [ ] Connection string obtained
echo.
echo 3. Environment Variables:
echo    [ ] Backend environment configured
echo    [ ] Frontend VITE_API_URL configured
echo.
echo ==================================
echo.

echo What would you like to do?
echo.
echo 1) Test frontend build locally
echo 2) Deploy frontend to Vercel
echo 3) Show deployment guide
echo 4) Exit
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto test_build
if "%choice%"=="2" goto deploy_frontend
if "%choice%"=="3" goto show_guide
if "%choice%"=="4" goto exit
goto invalid_choice

:test_build
echo.
echo Testing frontend build locally...
echo.
cd frontend
echo Installing dependencies...
call npm install
echo.
echo Building...
call npm run build
if %errorlevel% equ 0 (
    echo.
    echo Build successful!
    echo Output directory: frontend\dist
    echo.
    echo Preview build locally:
    echo    cd frontend ^&^& npm run preview
) else (
    echo.
    echo Build failed. Please fix errors before deploying.
    exit /b 1
)
cd ..
goto end

:deploy_frontend
echo.
echo Deploying Frontend to Vercel...
echo.

REM Check if Vercel CLI is installed
where vercel >nul 2>nul
if %errorlevel% neq 0 (
    echo Vercel CLI not found. Installing...
    call npm install -g vercel
)

cd frontend
echo Building frontend...
call npm install
call npm run build
echo.
echo Deploying to Vercel...
call vercel --prod
cd ..
echo.
echo Frontend deployment complete!
echo.
echo Don't forget to set environment variable in Vercel dashboard:
echo    VITE_API_URL = https://your-backend-url.com/api
goto end

:show_guide
echo.
echo Opening deployment guide...
if exist "VERCEL_DEPLOYMENT.md" (
    start VERCEL_DEPLOYMENT.md
) else (
    echo VERCEL_DEPLOYMENT.md not found
)
goto end

:invalid_choice
echo Invalid choice
exit /b 1

:exit
echo Goodbye!
exit /b 0

:end
echo.
echo ==================================
echo For more information, see:
echo    - VERCEL_DEPLOYMENT.md
echo    - https://vercel.com/docs
echo ==================================
pause
