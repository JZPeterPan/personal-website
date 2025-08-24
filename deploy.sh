#!/bin/bash

# Jiazhen Pan Website Deployment Script
# 自动部署脚本 - 将网站部署到GitHub Pages

set -e  # 遇到错误时退出

echo "🚀 开始部署 Jiazhen Pan 个人网站..."

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git 未安装，请先安装 Git${NC}"
    exit 1
fi

# 检查是否在正确的目录
if [ ! -f "index.html" ]; then
    echo -e "${RED}❌ 请在网站根目录运行此脚本${NC}"
    exit 1
fi

# 获取GitHub用户名
echo -e "${BLUE}📝 请输入您的GitHub用户名:${NC}"
read -r github_username

# 检查Git仓库状态
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}📁 初始化Git仓库...${NC}"
    git init
fi

# 添加所有文件
echo -e "${YELLOW}📦 添加文件到Git...${NC}"
git add .

# 检查是否有更改
if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  没有检测到更改${NC}"
else
    # 提交更改
    echo -e "${YELLOW}💾 提交更改...${NC}"
    git commit -m "Update website content - $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 检查远程仓库
if ! git remote get-url origin &> /dev/null; then
    echo -e "${YELLOW}🔗 添加远程仓库...${NC}"
    git remote add origin "https://github.com/$github_username/jiazhenpan-website.git"
fi

# 推送到GitHub
echo -e "${YELLOW}⬆️  推送到GitHub...${NC}"
git branch -M main
git push -u origin main

echo -e "${GREEN}✅ 文件已成功推送到GitHub!${NC}"
echo ""
echo -e "${BLUE}📋 接下来的步骤:${NC}"
echo "1. 访问 https://github.com/$github_username/jiazhenpan-website"
echo "2. 点击 'Settings' 标签"
echo "3. 在左侧菜单中找到 'Pages'"
echo "4. 在 'Source' 部分选择 'Deploy from a branch'"
echo "5. 选择 'main' 分支和 '/' 文件夹"
echo "6. 点击 'Save'"
echo ""
echo -e "${BLUE}🌐 配置自定义域名:${NC}"
echo "1. 在Pages设置中找到 'Custom domain'"
echo "2. 输入: jiazhenpan.me"
echo "3. 勾选 'Enforce HTTPS'"
echo "4. 点击 'Save'"
echo ""
echo -e "${BLUE}🔧 DNS配置 (在您的域名注册商处):${NC}"
echo "A记录:"
echo "  @ -> 185.199.108.153"
echo "  @ -> 185.199.109.153"
echo "  @ -> 185.199.110.153"
echo "  @ -> 185.199.111.153"
echo ""
echo "CNAME记录:"
echo "  www -> $github_username.github.io"
echo ""
echo -e "${GREEN}🎉 部署完成! 您的网站将在几分钟内可用。${NC}"
