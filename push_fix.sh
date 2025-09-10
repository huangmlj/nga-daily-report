#!/bin/bash
git add .
git commit -m "Fix GitHub Actions configuration: add secrets and fix workflow"
git push origin main
echo "✅ 修复已推送到GitHub"
echo ""
echo "🔗 现在访问：https://github.com/huangmlj/nga-daily-report/actions"
echo "点击 'Run workflow' 测试修复效果"
