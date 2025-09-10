#!/bin/bash

# NGA日报系统 - 完整部署验证脚本
# 适用于macOS本地环境

echo "🚀 NGA日报系统 - 完整部署验证"
echo "================================"

# 1. 检查Python环境
echo "🔍 检查Python环境..."
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    echo "✅ 使用 python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
    echo "✅ 使用 python"
else
    echo "❌ 未找到Python，请先安装Python"
    exit 1
fi

# 2. 安装依赖
echo "📦 安装依赖..."
$PYTHON_CMD -m pip install --upgrade pip
$PYTHON_CMD -m pip install -r requirements.txt

# 3. 本地测试
echo "🧪 运行本地测试..."
$PYTHON_CMD test_local.py

if [ $? -eq 0 ]; then
    echo "✅ 本地测试通过"
else
    echo "❌ 本地测试失败"
    exit 1
fi

# 4. 检查GitHub配置
echo "🔐 检查GitHub配置..."
echo ""
echo "📋 请确认以下配置已完成："
echo ""
echo "1. ✅ 代码已上传到GitHub: https://github.com/huangmlj/nga-daily-report"
echo "2. ✅ Secrets已配置:"
echo "   - 名称: QQ_EMAIL_PASSWORD"
echo "   - 值: fxsvktgdeuqvbjba"
echo "   - 配置地址: https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
echo ""

# 5. 提供下一步操作
echo "🎯 下一步操作："
echo ""
echo "方法1：手动触发测试"
echo "   访问: https://github.com/huangmlj/nga-daily-report/actions"
echo "   点击: 'Run workflow'"
echo ""
echo "方法2：等待定时运行"
echo "   系统将在每天北京时间22:00自动运行"
echo "   无需任何操作"
echo ""

# 6. 显示生成的文件
echo "📁 生成的文件："
if [ -f "test_report.html" ]; then
    echo "   ✅ test_report.html - 测试报告"
fi

if [ -f "nga_report.log" ]; then
    echo "   ✅ nga_report.log - 运行日志"
fi

echo ""
echo "🎉 部署验证完成！"
echo ""
echo "💡 提示："
echo "   - 检查邮箱: 360773337@qq.com"
echo "   - 查看日志: 打开 nga_report.log"
echo "   - 查看报告: 打开 test_report.html"
echo ""
echo "按任意键打开GitHub Actions页面..."
read -n 1 -s

# 打开浏览器
if command -v open &> /dev/null; then
    open "https://github.com/huangmlj/nga-daily-report/actions"
elif command -v xdg-open &> /dev/null; then
    xdg-open "https://github.com/huangmlj/nga-daily-report/actions"
else
    echo "请手动访问: https://github.com/huangmlj/nga-daily-report/actions"
fi