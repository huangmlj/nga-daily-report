#!/bin/bash

# NGA日报系统 - 一键配置GitHub Secrets
# 适用于已上传代码到GitHub的情况

echo "🔐 配置GitHub Secrets - 邮箱授权码"
echo ""
echo "📋 请按以下步骤操作："
echo ""
echo "1. 打开浏览器访问："
echo "   https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
echo ""
echo "2. 点击 'New repository secret'"
echo ""
echo "3. 填写信息："
echo "   Name: QQ_EMAIL_PASSWORD"
echo "   Value: fxsvktgdeuqvbjba"
echo ""
echo "4. 点击 'Add secret'"
echo ""
echo "5. 验证配置："
echo "   访问: https://github.com/huangmlj/nga-daily-report/actions"
echo "   点击 'Run workflow' 手动测试"
echo ""
echo "✅ 完成后，系统将每天22:00自动发送日报！"
echo ""
echo "按任意键打开浏览器配置页面..."
read -n 1 -s

# 尝试用默认浏览器打开配置页面
if command -v open &> /dev/null; then
    open "https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
elif command -v xdg-open &> /dev/null; then
    xdg-open "https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
else
    echo "请手动复制链接到浏览器打开"
fi