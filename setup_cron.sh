#!/bin/bash

# NGA日报定时任务设置脚本
# 此脚本用于在macOS/Linux系统上设置每晚10点自动发送NGA大时代板块日报

echo "🚀 开始设置NGA日报定时任务..."

# 获取当前目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/nga_daily_report.py"

# 检查Python脚本是否存在
if [[ ! -f "$PYTHON_SCRIPT" ]]; then
    echo "❌ 错误：找不到Python脚本 $PYTHON_SCRIPT"
    exit 1
fi

# 检查Python是否安装
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误：Python3 未安装"
    exit 1
fi

# 安装依赖
echo "📦 安装Python依赖..."
pip3 install -r requirements.txt

# 创建定时任务
CRON_JOB="0 22 * * * cd $SCRIPT_DIR && python3 nga_daily_report.py >> nga_report.log 2>&1"

# 检查是否已存在相同的定时任务
if crontab -l 2>/dev/null | grep -q "nga_daily_report.py"; then
    echo "⚠️  定时任务已存在，是否更新？(y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        # 删除旧任务
        crontab -l | grep -v "nga_daily_report.py" | crontab -
    else
        echo "✅ 保留现有定时任务"
        exit 0
    fi
fi

# 添加新任务
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

if [[ $? -eq 0 ]]; then
    echo "✅ 定时任务设置成功！"
    echo "⏰ 执行时间：每晚 22:00"
    echo "📧 脚本路径：$PYTHON_SCRIPT"
    echo "📊 日志文件：$SCRIPT_DIR/nga_report.log"
    echo ""
    echo "🔧 请记得："
    echo "1. 复制 .env.example 为 .env 并填写邮件配置"
    echo "2. 确保邮箱SMTP设置正确"
    echo "3. 可手动测试：python3 nga_daily_report.py"
else
    echo "❌ 定时任务设置失败"
    exit 1
fi

# 显示当前定时任务
echo ""
echo "📋 当前定时任务列表："
crontab -l