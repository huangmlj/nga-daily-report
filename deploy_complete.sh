#!/bin/bash

# 完整部署指南 - 从零开始配置GitHub Actions

echo "🚀 NGA日报系统 - 完整部署指南"
echo "============================="

# 1. 检查Git配置
echo "🔍 检查Git配置..."
if [ ! -d ".git" ]; then
    echo "❌ 当前目录不是Git仓库"
    echo "📁 请先初始化Git仓库："
    echo "   git init"
    echo "   git remote add origin https://github.com/huangmlj/nga-daily-report.git"
    exit 1
fi

echo "✅ Git仓库已配置"

# 2. 创建并推送工作流文件
echo "📝 创建GitHub Actions工作流..."

# 确保工作流目录存在
mkdir -p .github/workflows

# 创建工作流文件
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
    - name: Checkout code
      uses: actions/checkout@v4
    
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
        name: nga-daily-report-$(date +%Y%m%d)
        path: |
          *.html
          *.log
        retention-days: 7
EOF

echo "✅ 工作流文件已创建"

# 3. 确保所有文件已准备好
echo "📋 检查必要文件..."

required_files=(
    "nga_daily_report.py"
    "requirements.txt"
    ".github/workflows/daily-report.yml"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file 存在"
    else
        echo "❌ $file 缺失"
        exit 1
    fi
done

# 4. 本地测试
echo "🧪 运行本地测试..."
python3 test_local.py

if [ $? -eq 0 ]; then
    echo "✅ 本地测试通过"
else
    echo "❌ 本地测试失败"
    exit 1
fi

# 5. 创建一键推送脚本
cat > push_all.sh << 'EOF'
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
EOF

chmod +x push_all.sh

# 6. 显示最终状态
echo ""
echo "🎉 部署准备完成！"
echo ""
echo "📋 当前状态："
echo "   ✅ 所有文件已准备就绪"
echo "   ✅ 工作流已创建"
echo "   ✅ 本地测试通过"
echo ""
echo "🚀 执行以下命令完成部署："
echo "   ./push_all.sh"
echo ""
echo "💡 注意：首次推送后，需要在GitHub上："
echo "   1. 启用Actions"
echo "   2. 配置Secrets"
echo "   3. 手动触发测试"