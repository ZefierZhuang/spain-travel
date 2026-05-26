#!/bin/bash
# ==========================================
# 西班牙旅行攻略 - CloudStudio 一键部署脚本
# ==========================================

set -e

PORT=${PORT:-8080}
echo "🇪🇸 西班牙旅行攻略 - 部署中..."
echo "==============================="

# 检测当前目录是否有 index.html
if [ ! -f "index.html" ]; then
    echo "❌ 请在 spain-trip 目录下运行此脚本"
    exit 1
fi

# 检测图片是否存在
if [ ! -d "img" ] || [ $(ls img/*.jpg 2>/dev/null | wc -l) -lt 10 ]; then
    echo "⚠️  图片目录不完整，请确保 img/ 文件夹包含所有图片"
    exit 1
fi

echo "✅ 文件检查通过（index.html + $(ls img/*.jpg | wc -l) 张图片）"

# 尝试使用 Node.js serve（更稳定，支持 CORS）
if command -v npx &> /dev/null; then
    echo "🚀 使用 serve 启动（端口 $PORT）..."
    echo ""
    echo "================================================"
    echo "🌐 网站已启动！"
    echo "   本地访问: http://localhost:$PORT"
    echo "   公网访问: 查看 CloudStudio 端口转发面板"
    echo "================================================"
    echo ""
    npx --yes serve -s . -l $PORT --no-clipboard
elif command -v python3 &> /dev/null; then
    echo "🚀 使用 Python HTTP Server 启动（端口 $PORT）..."
    echo ""
    echo "================================================"
    echo "🌐 网站已启动！"
    echo "   本地访问: http://localhost:$PORT"
    echo "   公网访问: 查看 CloudStudio 端口转发面板"
    echo "================================================"
    echo ""
    python3 -m http.server $PORT
else
    echo "❌ 需要 Node.js 或 Python3，请先安装"
    exit 1
fi
