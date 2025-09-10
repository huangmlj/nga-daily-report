# 🎯 手动部署指南 - 绕过SSH问题

## 📋 超简单部署步骤

### **方案1：使用GitHub网页（推荐）**

#### **第1步：创建GitHub仓库**
1. 访问：https://github.com/new
2. Repository name: `nga-daily-report`
3. Description: `NGA大时代板块日报系统`
4. 选择 **Public**
5. 点击 **Create repository**

#### **第2步：上传代码**
1. 在新建的仓库页面，点击 **uploading an existing file**
2. 拖拽以下文件到上传区域：
   - `nga_daily_report.py`
   - `requirements.txt`
   - `.github/workflows/daily-report.yml`
   - `.env.example`

#### **第3步：配置Secrets**
1. 进入仓库 → Settings → Secrets and variables → Actions
2. 点击 **New repository secret**
3. Name: `QQ_EMAIL_PASSWORD`
4. Value: `fxsvktgdeuqvbjba`
5. 点击 **Add secret**

#### **第4步：验证运行**
1. 进入Actions页面
2. 点击 **Run workflow** 手动触发
3. 检查邮箱是否收到日报

### **方案2：使用GitHub Desktop（可视化）**

#### **第1步：下载GitHub Desktop**
- 访问：https://desktop.github.com/
- 下载并安装

#### **第2步：创建仓库**
1. 打开GitHub Desktop
2. 点击 **File → New Repository**
3. Name: `nga-daily-report`
4. Local path: 选择当前文件夹
5. 点击 **Create Repository**

#### **第3步：提交代码**
1. 填写Commit message: `Initial commit: NGA日报系统`
2. 点击 **Publish repository**
3. 选择 **GitHub.com** 和 **Public**
4. 点击 **Publish Repository**

#### **第4步：配置Secrets**
1. 在浏览器打开GitHub仓库
2. 按方案1的步骤配置Secrets

### **方案3：使用Gitee（国内替代）**

#### **第1步：创建Gitee仓库**
1. 访问：https://gitee.com/projects/new
2. 仓库名称: `nga-daily-report`
3. 点击 **创建**

#### **第2步：上传代码**
1. 点击 **文件 → 上传文件**
2. 上传所有项目文件

#### **第3步：配置Gitee Go**
1. 进入 **服务 → Gitee Go**
2. 创建流水线，使用类似配置

## 🎯 完成验证

部署完成后，访问：
- **GitHub:** https://github.com/你的用户名/nga-daily-report/actions
- **手动触发：** 点击 "Run workflow"

## 📅 定时规则
- **执行时间：** 每天北京时间22:00
- **自动运行：** 无需任何操作
- **完全免费：** 零成本运行

## 🎊 明天开始！
部署完成后，明天晚上10点您将收到第一份云端日报！

## 📞 技术支持
如果遇到问题：
1. 检查邮箱配置是否正确
2. 查看Actions运行日志
3. 重新运行手动测试