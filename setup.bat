@echo off
setlocal

echo ========================================
echo X-AnyLabeling GPU 環境自動安裝腳本
echo ========================================

REM 1) Clone 專案（若已存在則略過）
if exist "X-AnyLabeling" (
    echo [INFO] 偵測到 X-AnyLabeling 資料夾已存在，略過 git clone。
) else (
    echo [STEP] 下載專案原始碼...
    git clone https://github.com/CVHub520/X-AnyLabeling.git
    if errorlevel 1 (
        echo [ERROR] git clone 失敗，請確認 Git 已安裝且網路正常。
        exit /b 1
    )
)

REM 2) 進入資料夾並切換版本
cd /d "X-AnyLabeling"
echo [STEP] 切換到版本 v3.3.10 ...
git fetch --all --tags
git checkout v3.3.10
if errorlevel 1 (
    echo [ERROR] git checkout v3.3.10 失敗。
    exit /b 1
)

REM 3) 建立 conda 環境
echo [STEP] 建立 Conda 環境 anylabeling (Python 3.10) ...
conda create --name anylabeling python=3.10 -y
if errorlevel 1 (
    echo [ERROR] Conda 環境建立失敗。
    exit /b 1
)

REM 4) 啟動環境
call conda.bat activate anylabeling
if errorlevel 1 (
    echo [ERROR] 無法啟動 Conda 環境 anylabeling。
    echo [HINT] 請確認 Anaconda/Miniconda 已安裝且 conda.bat 可用。
    exit /b 1
)

REM 5) 安裝 cuDNN
echo [STEP] 安裝 cuDNN (CUDA 12) ...
conda install nvidia::cudnn cuda-version=12 -y
if errorlevel 1 (
    echo [ERROR] cuDNN 安裝失敗。
    exit /b 1
)

REM 6) 安裝 CUDA 12 專用 onnxruntime-gpu
echo [STEP] 安裝 onnxruntime-gpu (CUDA 12) ...
pip install onnxruntime-gpu --extra-index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-12/pypi/simple/
if errorlevel 1 (
    echo [ERROR] onnxruntime-gpu 安裝失敗。
    exit /b 1
)

REM 7) 安裝其他 GPU 依賴
echo [STEP] 安裝 requirements-gpu.txt ...
pip install -r requirements-gpu.txt
if errorlevel 1 (
    echo [ERROR] requirements-gpu.txt 安裝失敗。
    exit /b 1
)

REM 8) 驗證 onnxruntime 版本
echo [STEP] 驗證 onnxruntime 安裝結果 ...
pip list | findstr onnxruntime

echo.
echo [DONE] 安裝完成。你可以執行 start.bat 來啟動 X-AnyLabeling。
endlocal
