#!/bin/bash

# 网站部署状态检查脚本
# 检查 jiazhenpan.me 的部署状态

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 检查 jiazhenpan.me 部署状态...${NC}"
echo ""

# 检查DNS解析
echo -e "${YELLOW}📡 检查DNS解析...${NC}"
if nslookup jiazhenpan.me &> /dev/null; then
    echo -e "${GREEN}✅ DNS解析正常${NC}"
    nslookup jiazhenpan.me | grep -E "(Name:|Address:)"
else
    echo -e "${RED}❌ DNS解析失败${NC}"
fi
echo ""

# 检查网站可访问性
echo -e "${YELLOW}🌐 检查网站可访问性...${NC}"
if curl -s -o /dev/null -w "%{http_code}" https://jiazhenpan.me | grep -q "200"; then
    echo -e "${GREEN}✅ 网站可正常访问 (HTTPS)${NC}"
elif curl -s -o /dev/null -w "%{http_code}" http://jiazhenpan.me | grep -q "200"; then
    echo -e "${YELLOW}⚠️  网站可访问 (HTTP)，但建议启用HTTPS${NC}"
else
    echo -e "${RED}❌ 网站无法访问${NC}"
fi
echo ""

# 检查www子域名
echo -e "${YELLOW}🔗 检查www子域名...${NC}"
if curl -s -o /dev/null -w "%{http_code}" https://www.jiazhenpan.me | grep -q "200"; then
    echo -e "${GREEN}✅ www.jiazhenpan.me 可正常访问${NC}"
else
    echo -e "${YELLOW}⚠️  www.jiazhenpan.me 无法访问（可能需要配置CNAME记录）${NC}"
fi
echo ""

# 检查GitHub Pages状态
echo -e "${YELLOW}📋 检查GitHub Pages状态...${NC}"
if [ -d ".git" ]; then
    if git remote get-url origin &> /dev/null; then
        remote_url=$(git remote get-url origin)
        echo -e "${GREEN}✅ Git仓库已配置: $remote_url${NC}"
        
        # 提取GitHub用户名
        if [[ $remote_url =~ github\.com/([^/]+) ]]; then
            username=${BASH_REMATCH[1]}
            echo -e "${BLUE}📝 GitHub用户名: $username${NC}"
            echo -e "${BLUE}🔗 GitHub Pages URL: https://$username.github.io/jiazhenpan-website${NC}"
        fi
    else
        echo -e "${RED}❌ 未配置Git远程仓库${NC}"
    fi
else
    echo -e "${RED}❌ 当前目录不是Git仓库${NC}"
fi
echo ""

# 检查文件完整性
echo -e "${YELLOW}📁 检查网站文件...${NC}"
required_files=("index.html" "assets/css/styles.css" "assets/js/main.js")
missing_files=()

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file${NC}"
    else
        echo -e "${RED}❌ $file (缺失)${NC}"
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -eq 0 ]; then
    echo -e "${GREEN}✅ 所有必需文件都存在${NC}"
else
    echo -e "${RED}❌ 缺少 ${#missing_files[@]} 个文件${NC}"
fi
echo ""

# 提供建议
echo -e "${BLUE}💡 部署建议:${NC}"
echo "1. 如果DNS解析失败，请检查域名注册商的DNS设置"
echo "2. 如果网站无法访问，请确认GitHub Pages已启用"
echo "3. 如果缺少文件，请确保所有文件都已上传到GitHub"
echo "4. DNS更改可能需要几分钟到48小时才能生效"
echo ""

# 检查本地Git状态
if [ -d ".git" ]; then
    echo -e "${YELLOW}📊 本地Git状态...${NC}"
    if ! git diff --quiet; then
        echo -e "${YELLOW}⚠️  有未提交的更改${NC}"
        echo "建议运行: git add . && git commit -m 'Update' && git push"
    else
        echo -e "${GREEN}✅ 工作目录干净${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 检查完成！${NC}"
