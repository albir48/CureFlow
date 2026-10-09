@echo off
TITLE CureFlow Management Console
COLOR 0B

echo.
echo  ======================================================
echo     CUREFLOW HOSPITAL MANAGEMENT SYSTEM - LAUNCHER
echo  ======================================================
echo.

:: --- PHP DETECTION ---
set "PHP_EXE=php"
where php >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] PHP not found in PATH. Searching common locations...
    if exist "C:\xampp\php\php.exe" (
        set "PHP_EXE=C:\xampp\php\php.exe"
    ) else if exist "D:\xampp\php\php.exe" (
        set "PHP_EXE=D:\xampp\php\php.exe"
    ) else if exist "C:\php\php.exe" (
        set "PHP_EXE=C:\php\php.exe"
    ) else (
        echo [ERROR] PHP was not found on your system.
        echo Please ensure XAMPP is installed or PHP is in your PATH.
        pause
        exit /b
    )
    echo [SUCCESS] Found PHP at: %PHP_EXE%
)

:: --- NODE DETECTION ---
set "NODE_EXE=node"
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Node.js not found in PATH. Searching common locations...
    if exist "C:\Program Files\nodejs\node.exe" (
        set "NODE_EXE=C:\Program Files\nodejs\node.exe"
    ) else (
        echo [ERROR] Node.js was not found. Please install Node.js.
        pause
        exit /b
    )
)

echo [1/3] Starting PHP Backend API (Port 8080)...
:: Start PHP server with detected path
start "CureFlow Backend" /min "%PHP_EXE%" -S localhost:8080 -t .

echo [2/3] Starting React Frontend (Vite)...
:: Navigate to p1 and start npm dev
pushd p1
start "CureFlow Frontend" /min npm run dev
popd

echo [3/3] Waiting for servers to initialize...
timeout /t 5 /nobreak > nul

echo [DONE] Launching Browser...
start http://localhost:5173

echo.
echo  ------------------------------------------------------
echo   SYSTEM IS LIVE!
echo   Frontend: http://localhost:5173
echo   API/Chat: http://localhost:8080
echo  ------------------------------------------------------
echo.
echo  KEEP THIS WINDOW OPEN to maintain the connection.
echo  Press any key to SHUTDOWN all servers...
pause > nul

echo.
echo Cleaning up processes...
taskkill /FI "WINDOWTITLE eq CureFlow Backend" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq CureFlow Frontend" /T /F >nul 2>&1

echo.
echo CureFlow has been stopped safely.
timeout /t 2 > nul
exit
