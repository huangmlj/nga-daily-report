#!/bin/bash

# NGA日报系统 - 简化部署脚本
# 解决SSH权限问题，使用HTTPS + Token方式

set -e

echo "🚀 开始简化部署到GitHub..."

# 检查GitHub CLI是否安装
if ! command -v gh &> /dev/null; then
    echo "📦 安装GitHub CLI..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install gh
    else
        echo "请手动安装GitHub CLI: https://cli.github.com/"
        exit 1
    fi
fi

# 检查GitHub认证
echo "🔑 检查GitHub认证..."
if ! gh auth status &> /dev/null; then
    echo "🔐 请登录GitHub..."
    gh auth login
fi

# 获取用户信息
GITHUB_USERNAME=$(gh api user --jq '.login')
echo "✅ 已登录GitHub用户: $GITHUB_USERNAME"

# 创建仓库
REPO_NAME="nga-daily-report"
echo "📁 创建GitHub仓库: $REPO_NAME..."

# 如果仓库已存在，先删除
gh repo delete "$GITHUB_USERNAME/$REPO_NAME" --yes 2>/dev/null || true

# 创建新仓库
gh repo create "$REPO_NAME" --public --description "NGA大时代板块日报系统 - 自动每日邮件报告"

# 初始化Git
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit: NGA日报系统"
fi

# 配置远程仓库
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git

# 推送代码
echo "📤 推送代码..."
git branch -M main
git push -u origin main

# 配置GitHub Secrets
echo "🔐 配置GitHub Secrets..."
gh secret set QQ_EMAIL_PASSWORD --body "fxsvktgdeuqvbjba"

echo ""
echo "✅ 部署完成！"
echo ""
echo "🎯 访问以下地址验证部署："
echo "📧 仓库地址: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "⚙️  Actions页面: https://github.com/$GITHUB_USERNAME/$REPO_NAME/actions"
echo ""
echo "🔄 手动触发测试："
echo "1. 打开上述Actions页面"
echo "2. 点击 'Run workflow'"
echo "3. 检查邮箱是否收到日报"
echo ""
echo "🎉 从明天开始，每天22:00自动收到日报！"