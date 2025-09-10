# NGA大时代板块日报自动发送系统

这是一个自动化系统，每天晚上10点自动获取NGA大时代板块的发帖数据，并通过邮件发送到您的邮箱。

## 📋 功能特性

- **自动数据获取**：每日定时获取NGA大时代板块新帖数据
- **智能统计**：统计发帖数量、热门话题、回复量等关键指标
- **精美报告**：生成HTML格式的可视化报告
- **邮件推送**：自动发送到指定邮箱
- **错误处理**：完善的日志记录和错误处理机制

## 🚀 快速开始

### 1. 安装依赖

```bash
pip3 install -r requirements.txt
```

### 2. 配置邮件设置

复制配置文件模板：
```bash
cp .env.example .env
```

编辑 `.env` 文件，填写您的邮件配置：
```bash
# 邮件服务器配置
SMTP_SERVER=smtp.gmail.com  # 或您的邮件服务器
SMTP_PORT=587
SENDER_EMAIL=your_email@gmail.com
SENDER_PASSWORD=your_app_password  # 注意：不是邮箱密码，是应用专用密码
RECIPIENT_EMAIL=your_recipient@example.com
```

### 3. 设置定时任务

运行设置脚本：
```bash
./setup_cron.sh
```

此脚本会自动：
- 安装必要的Python包
- 创建每晚10点的定时任务
- 显示当前定时任务列表

### 4. 手动测试

在设置定时任务前，建议先手动测试：
```bash
python3 test_report.py
```

测试成功后会：
- 生成 `test_report.html` 本地报告文件
- 发送一封测试邮件到您的邮箱

## 📊 报告内容

每日报告包含：
- **今日发帖总数**
- **热门话题TOP10**
- **回复量和浏览量统计**
- **发帖时间分布**
- **话题趋势分析**

## 🔧 高级配置

### 邮件服务商设置

#### Gmail
- SMTP服务器：smtp.gmail.com
- 端口：587（TLS）或 465（SSL）
- 需要开启两步验证，使用应用专用密码

#### QQ邮箱
- SMTP服务器：smtp.qq.com
- 端口：587
- 需要在邮箱设置中开启SMTP服务，使用授权码

#### 163邮箱
- SMTP服务器：smtp.163.com
- 端口：25 或 587
- 需要在邮箱设置中开启SMTP服务

### 自定义数据获取

如需获取真实的NGA数据，需要：
1. 登录NGA论坛获取cookies
2. 修改 `nga_daily_report.py` 中的数据获取逻辑
3. 添加必要的headers和cookies

## 📁 文件说明

```
├── nga_daily_report.py    # 主要脚本，获取数据并发送邮件
├── test_report.py       # 测试脚本
├── setup_cron.sh        # 定时任务设置脚本
├── requirements.txt     # Python依赖包列表
├── .env.example       # 配置文件模板
├── .env                # 实际配置文件（需手动创建）
├── nga_report.log     # 运行日志
└── test_report.html   # 测试报告文件
```

## 🛠️ 故障排除

### 邮件发送失败
1. 检查SMTP配置是否正确
2. 确认邮箱已开启SMTP服务
3. 验证密码/授权码是否正确
4. 检查防火墙和网络连接

### 定时任务不执行
1. 检查cron服务是否运行：`sudo cron start`
2. 查看定时任务列表：`crontab -l`
3. 检查日志文件：`tail -f nga_report.log`

### 数据获取失败
1. 检查网络连接
2. 确认NGA网站可正常访问
3. 如需登录，请配置cookies

## 📞 技术支持

如有问题，请检查日志文件 `nga_report.log` 获取详细错误信息。

## ⚠️ 注意事项

- 请妥善保管 `.env` 文件中的邮箱密码
- 建议定期检查日志文件确保系统正常运行
- 如需停止定时任务，运行：`crontab -r`