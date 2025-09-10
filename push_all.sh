#!/bin/bash

echo "📤 推送所有文件到GitHub..."

git add .
git commit -m "Complete NGA Daily Report system with GitHub Actions"
git push origin main

echo "✅ 推送完成！"
echo ""
echo "🎯 下一步："
echo "1. 访问：https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
echo "2. 点击：New repository secret"
echo "3. 配置："
echo "   Name: QQ_EMAIL_PASSWORD"
echo "   Value: fxsvktgdeuqvbjba"
echo ""
echo "4. 访问：https://github.com/huangmlj/nga-daily-report/actions"
echo "5. 点击：I understand my workflows, go ahead and enable them"
echo "6. 点击：Run workflow"
