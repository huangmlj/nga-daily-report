#!/usr/bin/env python3
"""
本地测试脚本 - 使用.env文件配置
"""

import os
import sys
from dotenv import load_dotenv
from nga_daily_report import NGADailyReporter
import logging

# 加载.env文件
load_dotenv()

# 设置日志级别为DEBUG
logging.basicConfig(level=logging.DEBUG)

def test_local():
    """本地测试"""
    print("🔍 本地测试NGA日报系统...")
    
    # 检查.env文件
    print("📋 检查.env文件配置:")
    required_vars = ['SMTP_SERVER', 'SMTP_PORT', 'SENDER_EMAIL', 'RECIPIENT_EMAIL', 'SENDER_PASSWORD']
    
    for var in required_vars:
        value = os.getenv(var)
        if value:
            if 'PASSWORD' in var:
                masked_value = '*' * len(value)
                print(f"  ✅ {var}: {masked_value}")
            else:
                print(f"  ✅ {var}: {value}")
        else:
            print(f"  ❌ {var}: 未找到")
    
    # 测试数据生成
    print("\n📊 测试数据生成...")
    reporter = NGADailyReporter()
    
    data = reporter.get_daily_posts()
    if data:
        html_content = reporter.generate_html_report(data)
        
        # 保存HTML文件用于检查
        with open('test_report.html', 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        print("✅ HTML报告已生成: test_report.html")
        
        # 显示报告内容预览
        print("\n📧 报告预览:")
        print(f"日期: {data['date']}")
        print(f"总发帖数: {data['total_posts']}")
        print("热门话题:")
        for topic in data['hot_topics'][:3]:
            print(f"  - {topic['title']} (浏览:{topic['views']} 回复:{topic['replies']})")
        
        return True
    else:
        print("❌ 数据获取失败")
        return False

if __name__ == "__main__":
    success = test_local()
    
    if success:
        print("\n🎉 本地测试通过！")
        print("下一步：")
        print("1. 打开 test_report.html 查看生成的报告")
        print("2. 确保GitHub Secrets已配置 QQ_EMAIL_PASSWORD")
        print("3. 在GitHub Actions中手动触发测试")
    else:
        print("❌ 测试失败")
    
    sys.exit(0 if success else 1)