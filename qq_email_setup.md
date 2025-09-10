# QQ邮箱配置指南 - nga@802950.xyz

## 🔧 获取QQ邮箱授权码

由于您使用的是QQ邮箱，需要使用**授权码**而不是邮箱密码：

### 步骤1：开启SMTP服务
1. 登录QQ邮箱：https://mail.qq.com
2. 点击顶部【设置】→ 【账户】
3. 找到【POP3/SMTP服务】选项
4. 点击【开启】
5. 按提示发送短信验证

### 步骤2：获取授权码
1. 验证成功后，系统会显示16位授权码
2. **重要**：请复制保存这个授权码，它只显示一次
3. 授权码格式类似：`abcdefghijklmnop`

## 📝 配置.env文件

编辑 `/Users/huangmin/Desktop/Trae-9-9/.env` 文件：

```bash
# 邮件服务器配置
SMTP_SERVER=smtp.qq.com
SMTP_PORT=587
SENDER_EMAIL=nga@802950.xyz
SENDER_PASSWORD=这里填写16位授权码
RECIPIENT_EMAIL=nga@802950.xyz
```

## 🚀 快速测试

### 1. 安装依赖
```bash
pip3 install -r requirements.txt
```

### 2. 运行测试
```bash
python3 test_report.py
```

如果配置正确，您将收到一封测试邮件到 nga@802950.xyz

## ⚠️ 常见问题

### 邮件发送失败？
- **检查授权码**：确保使用的是16位授权码，不是QQ密码
- **检查SMTP设置**：确认SMTP服务器是smtp.qq.com，端口587
- **检查邮箱设置**：确认已在QQ邮箱中开启SMTP服务

### 安全提醒
- 授权码只显示一次，请妥善保存
- 如果授权码泄露，可在QQ邮箱中重新生成
- 不要将.env文件提交到代码仓库

## 📞 技术支持

如果测试成功，您可以继续设置定时任务：
```bash
./setup_cron.sh
```

这将设置每晚10点自动发送日报到您的邮箱。