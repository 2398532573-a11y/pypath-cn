@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
set "PORT=8788"
echo.
echo   Py启航 / PyPath 本地网站
echo   ==========================
echo   正在启动本地服务器，请不要关闭这个窗口。
echo   学习结束后，直接关闭窗口即可停止服务。
echo.

where node >nul 2>nul
if %errorlevel%==0 (
  start "pyqihang-server" /min cmd /c "node server.js"
  goto open
)

where python >nul 2>nul
if %errorlevel%==0 (
  start "pyqihang-server" /min cmd /c "python -m http.server %PORT% --bind 127.0.0.1"
  goto open
)

where py >nul 2>nul
if %errorlevel%==0 (
  start "pyqihang-server" /min cmd /c "py -3 -m http.server %PORT% --bind 127.0.0.1"
  goto open
)

echo   没有找到 Node.js 或 Python。
echo   你可以直接双击 index.html 打开网站首页。
echo   学习平台建议使用本地服务器，效果更稳定。
pause
exit /b 1

:open
timeout /t 2 >nul
start "" "http://127.0.0.1:%PORT%/"
echo   已打开：http://127.0.0.1:%PORT%/
echo.
pause