#!/bin/bash

# 我的潮汐 (My Tides) Python启动脚本

echo "================================================="
echo "    正在启动 我的潮汐 (My Tides) 服务器..."
echo "================================================="

# 获取本机IP地址
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS系统获取IP地址
    IP_ADDRESS=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)
else
    # Linux系统获取IP地址
    IP_ADDRESS=$(hostname -I | awk '{print $1}')
fi

# 如果IP地址为空，使用localhost
if [ -z "$IP_ADDRESS" ]; then
    IP_ADDRESS="localhost"
fi

# 设置端口
PORT=8080

# 显示访问地址
echo "================================================="
echo "  您的网站将可通过以下地址访问:"
echo "  http://$IP_ADDRESS:$PORT       (IP地址访问)"
echo "  http://localhost:$PORT         (本地访问)"
echo ""
echo "  要使用自定义域名访问，请执行以下操作之一:"
echo "  1. 运行 ./setup_hosts.sh 后，访问:"
echo "     http://my-tides:$PORT"
echo ""
echo "  2. 直接使用IP地址格式的域名:"
echo "     http://$IP_ADDRESS:$PORT/mytides"
echo "================================================="
echo "  将以上链接分享给其他人即可让他们访问您的网站"
echo "  (注意：他们需要与您在同一网络中才能访问)"
echo "================================================="

# 检查Python版本
python --version 2>/dev/null || python3 --version 2>/dev/null

# 提示用户按任意键继续
echo "按任意键继续启动服务器..."
read -n 1 -s

# 创建符号链接或目录，使/mytides路径可访问
if [ ! -e "mytides" ]; then
    echo "创建mytides目录链接..."
    # 在当前目录创建指向当前目录的符号链接
    ln -sf . mytides
fi

# 尝试使用python启动服务器，并绑定到所有网络接口（0.0.0.0）
if command -v python &> /dev/null; then
    echo "使用Python启动服务器..."
    python -m http.server $PORT --bind 0.0.0.0
elif command -v python3 &> /dev/null; then
    echo "使用Python3启动服务器..."
    python3 -m http.server $PORT --bind 0.0.0.0
else
    echo "错误: 未找到Python"
    exit 1
fi

echo "服务器已关闭" 