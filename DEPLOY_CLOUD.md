# ☁️ 云端部署指南 - 无需开机自动日报

## 🎯 GitHub Actions部署（推荐，完全免费）

### 📋 部署步骤

#### 1. 创建GitHub仓库
```bash
git init
git add .
git commit -m "Initial commit: NGA日报系统"
git remote add origin https://github.com/YOUR_USERNAME/nga-daily-report.git
git push -u origin main
```

#### 2. 配置GitHub Secrets
在GitHub仓库设置中，添加以下Secrets：
- `QQ_EMAIL_PASSWORD`: fxsvktgdeuqvbjba（您的16位授权码）

#### 3. 推送代码
```bash
git add .
git commit -m "Add GitHub Actions workflow"
git push
```

#### 4. 验证运行
- 访问GitHub仓库的Actions页面
- 点击"Run workflow"手动触发一次测试
- 检查邮箱是否收到日报

## 📅 定时规则
- **执行时间：** 每天北京时间22:00
- **触发机制：** GitHub Actions定时任务
- **运行时长：** 约2-3分钟
- **完全免费：** 每月2000分钟运行时间

## 📊 监控和日志
- **GitHub Actions日志：** 每次运行的详细日志
- **邮件发送：** 成功/失败都会记录
- **报告文件：** 自动保存为GitHub Actions artifacts

## 🔄 手动触发
随时可以在GitHub仓库的Actions页面手动触发运行：
1. 进入Actions标签页
2. 选择"NGA大时代板块日报"
3. 点击"Run workflow"

## 🛠️ 故障排查

### 邮件发送失败
- 检查Secrets中的授权码是否正确
- 确认邮箱SMTP设置（smtp.qq.com:465）

### 运行日志查看
1. 进入GitHub仓库的Actions页面
2. 点击最新的workflow运行
3. 查看详细日志输出

## 🆓 免费额度
- **GitHub Actions：** 每月2000分钟（本项目每天约3分钟，完全够用）
- **存储：** 500MB（代码+日志完全足够）
- **流量：** 无限制

## 🚀 优势
- ✅ 无需服务器，无需开机
- ✅ 完全免费，无隐藏费用
- ✅ 稳定可靠，99.9%可用性
- ✅ 全球CDN加速
- ✅ 自动日志和监控
- ✅ 支持手动触发测试

## 📁 部署后文件结构
```
.github/workflows/daily-report.yml  # GitHub Actions配置
nga_daily_report.py                # 主程序
requirements.txt                   # 依赖列表
.env.example                      # 配置模板
README.md                        # 项目说明
```

## 🎊 完成！
部署完成后，您将：
- **无需开机** - 日报每天自动发送到邮箱
- **无需维护** - GitHub负责所有运行环境
- **完全免费** - 零成本运行
- **稳定可靠** - GitHub的基础设施保障