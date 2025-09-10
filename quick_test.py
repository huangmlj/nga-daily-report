#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
快速测试脚本 - 专为nga@802950.xyz邮箱
"""

import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime

def quick_email_test():
    """快速邮件测试"""
    
    # 读取配置
    sender_email = "nga@802950.xyz"
    recipient_email = "nga@802950.xyz"
    
    # 提示用户输入授权码
    print("🎯 快速邮件测试")
    print("=" * 40)
    print("📧 邮箱：nga@802950.xyz")
    print("🔑 需要QQ邮箱16位授权码")
    print("获取方式：QQ邮箱 → 设置 → 账户 → 开启SMTP服务")
    print("=" * 40)
    
    auth_code = input("请输入16位QQ邮箱授权码: ").strip()
    
    if not auth_code or len(auth_code) != 16:
        print("❌ 授权码格式不正确，应为16位")
        return False
    
    try:
        # 创建测试邮件
        msg = MIMEMultipart('alternative')
        msg['Subject'] = f'NGA日报测试 - {datetime.now().strftime("%Y-%m-%d %H:%M")}'
        msg['From'] = sender_email
        msg['To'] = recipient_email
        
        html_content = f"""
        <html>
        <body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <h2 style="color: #007cba;">🎯 NGA大时代板块日报测试</h2>
            <p>您好！</p>
            <p>这是来自您的自动化系统的测试邮件。</p>
            
            <div style="background: #f5f5f5; padding: 20px; border-radius: 5px; margin: 20px 0;">
                <h3>📊 测试数据</h3>
                <p><strong>今日发帖：</strong>156篇</p>
                <p><strong>热门话题：</strong>药明康德、A股走势、新能源</p>
                <p><strong>发送时间：</strong>{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
            </div>
            
            <p>如果收到此邮件，说明您的配置正确！</p>
            <p>接下来可以运行：<code>./setup_cron.sh</code> 来设置定时任务</p>
            
            <hr>
            <p style="color: #666; font-size: 12px;">
                来自您的NGA日报自动化系统<br>
                邮箱：nga@802950.xyz
            </p>
        </body>
        </html>
        """
        
        html_part = MIMEText(html_content, 'html', 'utf-8')
        msg.attach(html_part)
        
        # 发送邮件
        print("📤 正在发送测试邮件...")
        
        server = smtplib.SMTP('smtp.qq.com', 587)
        server.starttls()
        server.login(sender_email, auth_code)
        server.send_message(msg)
        server.quit()
        
        print("✅ 测试邮件发送成功！")
        print("📧 请检查您的邮箱：nga@802950.xyz")
        print("\n下一步：")
        print("1. 编辑 .env 文件，填入授权码")
        print("2. 运行：./setup_cron.sh 设置定时任务")
        
        # 保存配置
        with open('.env', 'w') as f:
            f.write(f"""# NGA日报配置
SMTP_SERVER=smtp.qq.com
SMTP_PORT=587
SENDER_EMAIL=nga@802950.xyz
SENDER_PASSWORD={auth_code}
RECIPIENT_EMAIL=nga@802950.xyz
""")
        
        print("✅ 配置文件已自动更新")
        return True
        
    except Exception as e:
        print(f"❌ 发送失败: {str(e)}")
        print("💡 请检查：")
        print("- 授权码是否正确")
        print("- 网络连接是否正常")
        print("- QQ邮箱SMTP服务是否已开启")
        return False

if __name__ == "__main__":
    quick_email_test()