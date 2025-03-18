#!/bin/bash

# 我的潮汐 (My Tides) 启动脚本

echo "================================================="
echo "    正在启动 我的潮汐 (My Tides) 服务器..."
echo "================================================="

# 检查是否安装了Node.js
if ! command -v node &> /dev/null; then
    echo "错误: 未安装Node.js，请先安装Node.js"
    echo "可以从 https://nodejs.org 下载安装"
    exit 1
fi

# 启动服务器
node server.js

# 此处不会执行，除非服务器被终止
echo "服务器已关闭" 