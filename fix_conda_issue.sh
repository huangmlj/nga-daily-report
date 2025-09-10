#!/bin/bash

echo "🚀 修复GitHub Actions conda环境问题..."

# 检查当前目录
echo "当前目录: $(pwd)"
ls -la .github/workflows/

# 添加更改到git
echo "📁 添加新的workflow文件..."
git add .github/workflows/python-package.yml
git status

# 提交更改
echo "💾 提交更改..."
git commit -m "Fix GitHub Actions: replace conda with pip workflow

- 删除使用conda的workflow文件
- 创建新的基于pip的workflow
- 解决EnvironmentFileNotFound错误
- 添加push和PR触发器用于测试"

# 推送到GitHub
echo "🔄 推送到GitHub..."
git push origin main

echo "✅ 修复完成！"
echo ""
echo "📋 下一步操作："
echo "1. 访问 https://github.com/huangmlj/nga-daily-report/actions"
echo "2. 查看新的workflow是否出现"
echo "3. 点击 'Run workflow' 按钮测试"
echo ""
echo "如果推送失败，请检查："
echo "- 网络连接"
echo "- GitHub认证状态"
echo "- 分支权限"