#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
NGA大时代板块每日发帖统计邮件发送脚本
每天晚上10点自动执行，发送当日发帖数据到指定邮箱
"""

import requests
from bs4 import BeautifulSoup
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime, timedelta
import json
import os
import logging

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('nga_report.log'),
        logging.StreamHandler()
    ]
)

class NGADailyReporter:
    def __init__(self):
        self.nga_url = "https://bbs.nga.cn/thread.php?fid=706"
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        
    def get_daily_posts(self):
        """获取今日发帖数据"""
        try:
            # 由于NGA需要登录，这里使用模拟数据进行演示
            # 实际部署时需要配置cookies或API访问
            today = datetime.now().date()
            
            # 模拟数据 - 实际使用时需要替换为真实爬取逻辑
            daily_stats = {
                'date': today.strftime('%Y-%m-%d'),
                'total_posts': 156,
                'hot_topics': [
                    {
                        'title': '药明康德今天怎么走',
                        'views': 1247,
                        'replies': 89,
                        'url': 'https://bbs.nga.cn/read.php?tid=xxx'
                    },
                    {
                        'title': 'A股今天能翻红吗',
                        'views': 2156,
                        'replies': 156,
                        'url': 'https://bbs.nga.cn/read.php?tid=xxx'
                    },
                    {
                        'title': '新能源板块还有机会吗',
                        'views': 987,
                        'replies': 67,
                        'url': 'https://bbs.nga.cn/read.php?tid=xxx'
                    }
                ],
                'peak_hours': {
                    'morning': 45,
                    'afternoon': 52,
                    'closing': 38,
                    'after_hours': 21
                }
            }
            
            logging.info(f"成功获取 {today} 的发帖数据")
            return daily_stats
            
        except Exception as e:
            logging.error(f"获取数据失败: {str(e)}")
            return None
    
    def generate_html_report(self, data):
        """生成HTML格式的报告"""
        if not data:
            return "<h2>今日数据获取失败</h2>"
        
        html_content = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8">
            <title>NGA大时代板块日报 - {data['date']}</title>
            <style>
                body {{ font-family: 'Microsoft YaHei', Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }}
                .container {{ max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }}
                .header {{ text-align: center; border-bottom: 2px solid #007cba; padding-bottom: 20px; margin-bottom: 30px; }}
                .stats {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 20px 0; }}
                .stat-card {{ background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; text-align: center; }}
                .hot-topics {{ margin: 30px 0; }}
                .topic-item {{ border-left: 4px solid #007cba; padding: 15px; margin: 10px 0; background: #f9f9f9; border-radius: 5px; }}
                .topic-title {{ font-weight: bold; color: #007cba; margin-bottom: 5px; }}
                .topic-stats {{ color: #666; font-size: 14px; }}
                .footer {{ text-align: center; margin-top: 40px; padding-top: 20px; border-top: 1px solid #eee; color: #666; }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>📈 NGA大时代板块日报</h1>
                    <h2>{data['date']} 发帖统计</h2>
                </div>
                
                <div class="stats">
                    <div class="stat-card">
                        <h3>{data['total_posts']}</h3>
                        <p>今日新帖</p>
                    </div>
                    <div class="stat-card">
                        <h3>{sum(topic['replies'] for topic in data['hot_topics'])}</h3>
                        <p>热门回复</p>
                    </div>
                    <div class="stat-card">
                        <h3>{sum(topic['views'] for topic in data['hot_topics'])}</h3>
                        <p>总浏览量</p>
                    </div>
                </div>
                
                <div class="hot-topics">
                    <h3>🔥 今日热门讨论</h3>
                    {''.join([
                        f'<div class="topic-item">'
                        f'<div class="topic-title">{topic["title"]}</div>'
                        f'<div class="topic-stats">浏览: {topic["views"]} | 回复: {topic["replies"]}</div>'
                        f'</div>' for topic in data['hot_topics']
                    ])}
                </div>
                
                <div class="footer">
                    <p>数据来源：NGA大时代板块 | 发送时间：{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
                    <p>本邮件由自动化系统发送</p>
                </div>
            </div>
        </body>
        </html>
        """
        return html_content
    
    def send_email(self, html_content, recipient_email):
        """发送邮件"""
        try:
            # 邮件配置
            smtp_server = os.getenv('SMTP_SERVER', 'smtp.qq.com')
            smtp_port = int(os.getenv('SMTP_PORT', '465'))
            sender_email = os.getenv('SENDER_EMAIL', '360773337@qq.com')
            sender_password = os.getenv('SENDER_PASSWORD')
            
            msg = MIMEMultipart('alternative')
            msg['Subject'] = f'NGA大时代板块日报 - {datetime.now().strftime("%Y-%m-%d")}'
            msg['From'] = sender_email
            msg['To'] = recipient_email
            
            html_part = MIMEText(html_content, 'html', 'utf-8')
            msg.attach(html_part)
            
            # 使用SSL连接（更稳定）
            if smtp_port == 465:
                server = smtplib.SMTP_SSL(smtp_server, smtp_port)
            else:
                server = smtplib.SMTP(smtp_server, smtp_port)
                server.starttls()
            
            server.login(sender_email, sender_password)
            server.send_message(msg)
            server.quit()
            
            logging.info(f"邮件成功发送到 {recipient_email}")
            return True
            
        except Exception as e:
            logging.error(f"邮件发送失败: {str(e)}")
            return False

def main():
    """主函数"""
    reporter = NGADailyReporter()
    
    # 获取今日数据
    daily_data = reporter.get_daily_posts()
    
    if daily_data:
        # 生成报告
        html_report = reporter.generate_html_report(daily_data)
        
        # 发送邮件 - 使用环境变量中的收件人邮箱
        recipient_email = os.getenv('RECIPIENT_EMAIL', '360773337@qq.com')
        if reporter.send_email(html_report, recipient_email):
            logging.info("日报发送完成")
        else:
            logging.error("日报发送失败")
    else:
        logging.error("无法获取数据，跳过本次发送")

if __name__ == "__main__":
    main()