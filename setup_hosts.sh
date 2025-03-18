#!/bin/bash

# 我的潮汐 (My Tides) hosts文件设置脚本
# 此脚本将帮助您将my-tides域名映射到您的本地IP地址

echo "================================================="
echo "    我的潮汐 (My Tides) 域名设置工具"
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
    # 使用回环地址
    IP_ADDRESS="127.0.0.1"
    echo "警告: 无法获取本机IP地址，将使用127.0.0.1"
fi

# hosts文件路径
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS系统
    HOSTS_FILE="/etc/hosts"
    USE_SUDO=true
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows系统 (Git Bash 或 MSYS)
    HOSTS_FILE="/c/Windows/System32/drivers/etc/hosts"
    USE_SUDO=false
else
    # 默认为Linux系统
    HOSTS_FILE="/etc/hosts"
    USE_SUDO=true
fi

echo "此脚本将修改您的hosts文件，添加以下映射:"
echo "$IP_ADDRESS  my-tides"
echo "这将允许您通过http://my-tides:8080访问应用"
echo ""
echo "注意: 此操作可能需要管理员权限"
echo ""

read -p "是否继续? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "操作已取消"
    exit 0
fi

# 创建临时文件
TEMP_FILE=$(mktemp)

# 检查是否已存在映射并创建新hosts文件内容
if [ -f "$HOSTS_FILE" ]; then
    # 过滤掉已有的my-tides条目
    grep -v "my-tides" "$HOSTS_FILE" > "$TEMP_FILE"
else
    # 如果hosts文件不存在，创建空文件
    touch "$TEMP_FILE"
fi

# 添加新的my-tides映射
echo "$IP_ADDRESS  my-tides" >> "$TEMP_FILE"

# 更新hosts文件
if [ "$USE_SUDO" = true ]; then
    echo "使用管理员权限更新hosts文件..."
    sudo cp "$TEMP_FILE" "$HOSTS_FILE"
    RESULT=$?
else
    echo "更新hosts文件..."
    cp "$TEMP_FILE" "$HOSTS_FILE"
    RESULT=$?
fi

# 清理临时文件
rm "$TEMP_FILE"

if [ $RESULT -eq 0 ]; then
    echo "================================================="
    echo "  域名设置成功!"
    echo "  现在您可以通过以下地址访问应用:"
    echo "  http://my-tides:8080"
    echo "================================================="
    
    # 清除DNS缓存
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "正在清除DNS缓存..."
        sudo dscacheutil -flushcache
        sudo killall -HUP mDNSResponder
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        # Windows
        echo "请手动清除DNS缓存，在管理员命令提示符中运行: ipconfig /flushdns"
    else
        # Linux
        echo "如果域名仍不可用，可能需要清除DNS缓存"
        echo "在终端中尝试: sudo systemd-resolve --flush-caches"
    fi
    
    echo "如果域名仍然无法访问，请尝试关闭并重新打开浏览器"
    echo "================================================="
else
    echo "================================================="
    echo "  域名设置失败，请尝试手动修改hosts文件"
    echo "  请将以下行添加到 $HOSTS_FILE 文件:"
    echo "  $IP_ADDRESS  my-tides"
    echo "================================================="
fi 