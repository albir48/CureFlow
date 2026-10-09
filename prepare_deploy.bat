@echo off
TITLE CureFlow - Prepare Online Deployment
COLOR 0A

echo.
echo  ======================================================
echo     PREPARING CUREFLOW FOR ONLINE DEPLOYMENT
echo  ======================================================
echo.

:: 1. Build React App
echo [1/3] Building React Frontend...
pushd p1
cmd /c "npm run build"
if %errorlevel% neq 0 (
    echo [ERROR] React build failed.
    pause
    exit /b
)
popd

:: 2. Copy PHP files to public_html
echo [2/3] Merging PHP Backend into public_html...
xcopy /E /I /Y "config" "public_html\config" >nul
xcopy /E /I /Y "utils" "public_html\utils" >nul
xcopy /E /I /Y "api" "public_html\api" >nul
copy /Y "*.php" "public_html\" >nul
copy /Y "hospital_settings.json" "public_html\" >nul
xcopy /E /I /Y "uploads" "public_html\uploads" >nul

:: 3. Create .htaccess for SPA routing
echo RewriteEngine On > "public_html\.htaccess"
echo RewriteBase / >> "public_html\.htaccess"
echo RewriteRule ^index\.html$ - [L] >> "public_html\.htaccess"
echo RewriteCond %%{REQUEST_FILENAME} !-f >> "public_html\.htaccess"
echo RewriteCond %%{REQUEST_FILENAME} !-d >> "public_html\.htaccess"
echo RewriteRule . /index.html [L] >> "public_html\.htaccess"

:: 4. Finish
echo [3/3] Deployment folder ready!
echo.
echo  ------------------------------------------------------
echo   DONE! Your website is ready in the 'public_html' folder.
echo   Simply upload the CONTENTS of 'public_html' to your 
echo   free host (like InfinityFree or 000webhost).
echo  ------------------------------------------------------
echo.
echo  Note: This did NOT change your local files. 
echo  Your offline 'run_cureflow.bat' still works perfectly.
echo.
pause
