@echo off
setlocal

echo ========================================
echo 啟動 X-AnyLabeling (GPU)
echo ========================================

call conda.bat activate anylabeling
if errorlevel 1 (
    echo [ERROR] 無法啟動 Conda 環境 anylabeling。
    echo [HINT] 請先執行 setup.bat 完成安裝。
    exit /b 1
)

python X-AnyLabeling/anylabeling/app.py
if errorlevel 1 (
    echo [ERROR] 啟動失敗，請確認 X-AnyLabeling 專案已下載且依賴已安裝。
    exit /b 1
)

endlocal
