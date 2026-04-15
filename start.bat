@echo off
setlocal
chcp 65001 >nul
set "PYTHONIOENCODING=utf-8"
set "PYTHONUTF8=1"
set "NO_COLOR=1"
set "FORCE_COLOR=0"

echo ========================================
echo 啟動 X-AnyLabeling (GPU)
echo ========================================

where conda >nul 2>&1
if errorlevel 1 (
    echo [ERROR] 找不到 conda 指令，請使用 Anaconda Prompt 或先設定 PATH。
    exit /b 1
)

conda run -n anylabeling python X-AnyLabeling/anylabeling/app.py
if errorlevel 1 (
    echo [ERROR] 啟動失敗，請確認 X-AnyLabeling 專案已下載且依賴已安裝。
    exit /b 1
)

endlocal
