#!/bin/bash

# NGA日报系统 - 一键GitHub部署脚本
# 解决网络连接问题

set -e

echo "🚀 开始部署NGA日报系统到GitHub..."

# 检查网络连接
echo "📡 检查网络连接..."
if ! curl -s --connect-timeout 5 https://github.com > /dev/null; then
    echo "❌ 网络连接失败，请检查网络设置"
    exit 1
fi

# 配置Git使用SSH
echo "🔑 配置SSH密钥..."
git config --global core.sshCommand "ssh -i ~/.ssh/nga_github_key -o StrictHostKeyChecking=no"

# 创建GitHub仓库（如果用户尚未创建）
echo "📁 准备GitHub仓库..."
read -p "请输入您的GitHub用户名: " GITHUB_USERNAME
read -p "请输入仓库名称(默认: nga-daily-report): " REPO_NAME
REPO_NAME=${REPO_NAME:-nga-daily-report}

# 初始化Git仓库
if [ ! -d ".git" ]; then
    echo "📝 初始化Git仓库..."
    git init
    git add .
    git commit -m "Initial commit: NGA日报系统"
fi

# 添加远程仓库
echo "🔗 配置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git

# 设置SSH密钥权限
chmod 600 ~/.ssh/nga_github_key

# 推送代码
echo "📤 推送代码到GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ 代码推送成功！"
echo ""
echo "📋 下一步操作："
echo "1. 访问 https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/secrets/actions"
echo "2. 点击 'New repository secret'"
echo "3. Name: QQ_EMAIL_PASSWORD"
echo "4. Value: fxsvktgdeuqvbjba"
echo "5. 保存后，系统将在每天22:00自动运行"
echo ""
echo "🔍 验证部署："
echo "- 访问: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/actions"
echo "- 点击 'Run workflow' 手动测试"
echo ""
echo "🎉 部署完成！明天晚上10点将收到第一份云端日报！"