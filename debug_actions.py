#!/usr/bin/env python3
"""
GitHub Actions错误诊断脚本
用于快速定位和修复GitHub Actions问题
"""

import os
import subprocess
import re

def check_workflow_file():
    """检查工作流文件格式"""
    workflow_path = ".github/workflows/daily-report.yml"
    
    if not os.path.exists(workflow_path):
        print("❌ 工作流文件不存在")
        return False
    
    try:
        with open(workflow_path, 'r') as f:
            content = f.read()
        
        # 基本格式检查
        if 'on:' in content and 'jobs:' in content:
            print("✅ 工作流文件格式基本正确")
            return True
        else:
            print("❌ 工作流文件格式错误")
            return False
    except Exception as e:
        print(f"❌ 文件读取错误: {e}")
        return False

def check_secrets():
    """检查环境变量配置"""
    required_vars = [
        'SMTP_SERVER',
        'SMTP_PORT',
        'SENDER_EMAIL',
        'RECIPIENT_EMAIL',
        'SENDER_PASSWORD'
    ]
    
    missing = []
    for var in required_vars:
        if not os.getenv(var):
            missing.append(var)
    
    if missing:
        print(f"❌ 缺失环境变量: {missing}")
        return False
    
    print("✅ 所有环境变量已配置")
    return True

def check_requirements():
    """检查依赖包"""
    try:
        subprocess.run(['python3', '-c', 'import requests, bs4, lxml'], 
                      check=True, capture_output=True)
        print("✅ 所有依赖包已安装")
        return True
    except subprocess.CalledProcessError:
        print("❌ 依赖包缺失")
        return False

def check_file_permissions():
    """检查文件权限"""
    files = [
        'nga_daily_report.py',
        'test_local.py',
        'test_github_action.py'
    ]
    
    for file in files:
        if not os.access(file, os.R_OK):
            print(f"❌ 文件不可读: {file}")
            return False
    
    print("✅ 所有文件权限正确")
    return True

def main():
    print("🔍 GitHub Actions错误诊断")
    print("=" * 40)
    
    checks = [
        ("工作流文件", check_workflow_file),
        ("环境变量", check_secrets),
        ("依赖包", check_requirements),
        ("文件权限", check_file_permissions)
    ]
    
    passed = 0
    for name, check_func in checks:
        print(f"\n{name}检查:")
        if check_func():
            passed += 1
    
    print(f"\n📊 检查结果: {passed}/{len(checks)} 通过")
    
    if passed == len(checks):
        print("🎉 所有检查通过，GitHub Actions应该正常工作")
    else:
        print("⚠️  发现问题，请根据提示修复")

if __name__ == "__main__":
    main()