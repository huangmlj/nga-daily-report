#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
NGA日报测试脚本
用于手动测试邮件发送功能
"""

import os
import sys
from nga_daily_report import NGADailyReporter
from dotenv import load_dotenv

def test_report():
    """测试日报功能"""
    print("🧪 开始测试NGA日报功能...")
    
    # 加载环境变量
    load_dotenv()
    
    # 检查必要配置
    required_env = ['SENDER_EMAIL', 'SENDER_PASSWORD', 'RECIPIENT_EMAIL']
    missing = [env for env in required_env if not os.getenv(env)]
    
    if missing:
        print(f"❌ 缺少环境变量: {', '.join(missing)}")
        print("请复制 .env.example 为 .env 并填写配置")
        return False
    
    # 创建报告器
    reporter = NGADailyReporter()
    
    # 获取数据
    print("📊 获取NGA数据...")
    data = reporter.get_daily_posts()
    
    if not data:
        print("❌ 无法获取数据")
        return False
    
    print(f"✅ 获取到 {data['total_posts']} 个新帖子")
    
    # 生成报告
    print("📝 生成报告...")
    html_content = reporter.generate_html_report(data)
    
    # 保存本地测试文件
    with open('test_report.html', 'w', encoding='utf-8') as f:
        f.write(html_content)
    print("✅ 报告已保存到 test_report.html")
    
    # 发送邮件
    print("📧 发送测试邮件...")
    recipient = os.getenv('RECIPIENT_EMAIL')
    
    if reporter.send_email(html_content, recipient):
        print("✅ 测试邮件发送成功！")
        return True
    else:
        print("❌ 邮件发送失败")
        return False

if __name__ == "__main__":
    test_report()