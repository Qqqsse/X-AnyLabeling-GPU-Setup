# X-AnyLabeling GPU 標記環境說明

## 前言

本實驗室統一使用 **Source code** 方式執行 X-AnyLabeling 的 GPU 版本，以提升影像辨識與標記速度。  
原因是官方釋出的 `exe` 版本主要為 CPU 流程，推論效能相對較慢，不利大量資料標註。

---

## 環境建置與啟動方式

### 1) 第一次安裝（只需做一次）

1. 開啟 `cmd`（建議使用「Anaconda Prompt」或已可用 `conda` 的終端）。
2. 切到本專案所在資料夾。
3. 執行：

```bat
setup.bat
```

此腳本會自動完成：
- 下載 `X-AnyLabeling` 原始碼。
- 切換到 `v3.3.10`。
- 建立 `anylabeling` conda 環境（Python 3.10）。
- 安裝 cuDNN（CUDA 12）。
- 安裝 CUDA 12 專用 `onnxruntime-gpu`。
- 安裝 `requirements-gpu.txt` 內其他 GPU 依賴。
- 透過 `pip list | findstr onnxruntime` 驗證版本。

### 2) 日常啟動

每次要開啟工具時，在同一層資料夾執行：

```bat
start.bat
```

此腳本會使用 `conda run -n anylabeling` 方式啟動（比 `conda activate` 在批次檔中更穩定），並執行：

```bat
conda run -n anylabeling python X-AnyLabeling/anylabeling/app.py
```

---

## 操作指南

1. 點選左邊工作列的 **AI** 符號。  
2. 在上方點擊並選擇要使用的模型。  

---

## 常用快捷鍵

- `q`：偵測物件
- `e`：移除區域
- `b`：清空
- `f`：儲存並給標籤
- `ctrl+n`：自繪多邊形
- `ctrl+j`：調整標記
- `a / d`：上一張 / 下一張

---

## 內建模型支援（v3.3.10）

- **互動式分割模型**
  - SAM 2 / 2.1（目前最強）
  - HQ-SAM（針對精細邊緣）
  - 輕量化版本

- **文本導引偵測**
  - Grounding DINO
  - Grounding DINO + SAM 2

- **YOLO 全系列**
  - YOLOv5 到 YOLOv11

- **影像打標**
  - RAM
  - Tag2Text

- **專用模型**
  - RT-DETR
  - MediaPipe
  - PaddleOCR

- **自定義模型**
  - 支援匯入自定義 ONNX 模型

---

## 備註

- 你的系統已安裝全域 CUDA 12.6，可搭配本流程使用。
- 若 `conda` 指令無法使用，請改用 Anaconda Prompt，或先完成 conda 初始化設定。
- 若 `cmd` 出現中文亂碼，請確認批次檔以 UTF-8 儲存，並由腳本自動切換到 UTF-8 code page（`chcp 65001`）。
