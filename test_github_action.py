#!/usr/bin/env python3
"""
GitHub Actions测试脚本
用于验证环境变量和邮件配置是否正确
"""

import os
import sys
from nga_daily_report import NGADailyReporter
import logging

# 设置日志级别为DEBUG
logging.basicConfig(level=logging.DEBUG)

def test_github_action():
    """测试GitHub Actions配置"""
    print("🔍 测试GitHub Actions配置...")
    
    # 检查环境变量
    print("📋 环境变量检查:")
    required_vars = ['SMTP_SERVER', 'SMTP_PORT', 'SENDER_EMAIL', 'RECIPIENT_EMAIL', 'SENDER_PASSWORD']
    
    for var in required_vars:
        value = os.getenv(var)
        if value:
            # 隐藏密码
            if 'PASSWORD' in var:
                masked_value = '*' * len(value)
                print(f"  ✅ {var}: {masked_value}")
            else:
                print(f"  ✅ {var}: {value}")
        else:
            print(f"  ❌ {var}: 未设置")
    
    # 测试邮件发送
    print("\n📧 测试邮件发送...")
    reporter = NGADailyReporter()
    
    # 获取测试数据
    data = reporter.get_daily_posts()
    if data:
        html_content = reporter.generate_html_report(data)
        
        # 使用环境变量中的邮箱
        recipient = os.getenv('RECIPIENT_EMAIL', '360773337@qq.com')
        print(f"发送邮件到: {recipient}")
        
        success = reporter.send_email(html_content, recipient)
        if success:
            print("✅ 邮件发送成功！")
            return True
        else:
            print("❌ 邮件发送失败")
            return False
    else:
        print("❌ 无法获取数据")
        return False

if __name__ == "__main__":
    success = test_github_action()
    sys.exit(0 if success else 1)