@echo off
REM DSH 插件市场索引本地服务
REM 为 DSH 的 Discover 页提供本地缓存的索引，避免网络慢导致超时

set CACHE_DIR=C:\Users\jay\.dsh\profiles\desktop\.market-cache
set PORT=18765
set LOG=%CACHE_DIR%\server.log

cd /d "%CACHE_DIR%"
python -m http.server %PORT% --bind 127.0.0.1 >> "%LOG%" 2>&1
