#!/bin/bash

# GitHub Actions 一键修复脚本
# 解决环境变量配置问题

echo "🔧 GitHub Actions 一键修复"
echo "=========================="

# 1. 显示当前状态
echo "📊 当前状态检查..."
echo ""

# 2. 创建修复后的工作流文件
echo "📝 修复工作流配置..."

cat > .github/workflows/daily-report.yml << 'EOF'
name: NGA Daily Report

on:
  schedule:
    - cron: '0 14 * * *'  # 每天北京时间22:00运行
  workflow_dispatch:  # 允许手动触发

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python 3.10
      uses: actions/setup-python@v4
      with:
        python-version: '3.10'
        cache: 'pip'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    
    - name: Run daily report
      env:
        SMTP_SERVER: smtp.qq.com
        SMTP_PORT: 587
        SENDER_EMAIL: 360773337@qq.com
        RECIPIENT_EMAIL: 360773337@qq.com
        SENDER_PASSWORD: ${{ secrets.QQ_EMAIL_PASSWORD }}
      run: |
        python nga_daily_report.py
    
    - name: Upload report
      uses: actions/upload-artifact@v4
      if: always()
      with:
        name: nga-daily-report
        path: |
          *.html
          *.log
        retention-days: 7
EOF

echo "✅ 工作流文件已修复"

# 3. 显示配置说明
echo ""
echo "🎯 修复完成！请按以下步骤操作："
echo ""
echo "1. 推送修复后的文件："
echo "   git add ."
echo "   git commit -m 'Fix GitHub Actions configuration'"
echo "   git push origin main"
echo ""
echo "2. 配置GitHub Secrets："
echo "   访问：https://github.com/huangmlj/nga-daily-report/settings/secrets/actions"
echo "   点击：New repository secret"
echo "   Name: QQ_EMAIL_PASSWORD"
echo "   Value: fxsvktgdeuqvbjba"
echo ""
echo "3. 测试运行："
echo "   访问：https://github.com/huangmlj/nga-daily-report/actions"
echo "   点击：Run workflow"
echo ""

# 4. 创建Git配置脚本
cat > push_fix.sh << 'EOF'
#!/bin/bash
git add .
git commit -m "Fix GitHub Actions configuration: add secrets and fix workflow"
git push origin main
echo "✅ 修复已推送到GitHub"
echo ""
echo "🔗 现在访问：https://github.com/huangmlj/nga-daily-report/actions"
echo "点击 'Run workflow' 测试修复效果"
EOF

chmod +x push_fix.sh

echo "🚀 一键推送脚本已创建：./push_fix.sh"