# 🔧 GitHub云端部署指南

## 📋 网络问题解决方案

由于网络连接问题，我们使用SSH方式部署到GitHub。

## 🚀 一键部署步骤

### **第1步：运行一键部署脚本**
```bash
./deploy_github.sh
```

### **第2步：配置SSH密钥到GitHub**
1. 复制下面的公钥：
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM9X16nzWOt/4mTJiaFG7FPnHwpuHJaF6oKnVFy5bIWe 360773337@qq.com
```

2. 访问：https://github.com/settings/keys
3. 点击"New SSH key"
4. Title: `NGA日报系统`
5. Key: 粘贴上面的公钥
6. 点击"Add SSH key"

### **第3步：创建GitHub仓库**
1. 访问：https://github.com/new
2. Repository name: `nga-daily-report`
3. 选择"Public"（免费Actions）
4. 不要勾选"Initialize with README"
5. 点击"Create repository"

### **第4步：配置邮箱授权码**
1. 访问：https://github.com/YOUR_USERNAME/nga-daily-report/settings/secrets/actions
2. 点击"New repository secret"
3. Name: `QQ_EMAIL_PASSWORD`
4. Value: `fxsvktgdeuqvbjba`
5. 点击"Add secret"

### **第5步：验证部署**
1. 访问：https://github.com/YOUR_USERNAME/nga-daily-report/actions
2. 点击"Run workflow"手动测试
3. 检查邮箱是否收到日报

## 📅 定时规则
- **执行时间：** 每天北京时间22:00
- **时区：** UTC+8（北京时间）
- **运行时长：** 约2-3分钟

## 🔄 手动触发
随时可以在GitHub仓库的Actions页面手动触发运行。

## 📊 监控和日志
- **运行日志：** GitHub Actions页面查看
- **邮件状态：** 检查邮箱收件箱
- **报告文件：** 自动保存为Artifacts

## 🆓 免费额度
- **GitHub Actions：** 每月2000分钟（本项目每天约3分钟）
- **存储：** 500MB完全够用
- **完全免费：** 零成本运行

## 🎯 完成确认
部署完成后，您将：
- ✅ 无需开机，日报自动发送
- ✅ 每天22:00准时收到邮件
- ✅ 完全免费，稳定可靠
- ✅ 支持手动触发测试

## 🛠️ 故障排查

### SSH连接失败
```bash
# 测试SSH连接
ssh -T git@github.com
```

### 网络问题
如果遇到网络问题，可以尝试：
1. 使用国内GitHub镜像
2. 配置代理
3. 使用Gitee作为替代方案

## 🎊 明天开始！
部署完成后，明天晚上10点您将收到第一份云端日报！