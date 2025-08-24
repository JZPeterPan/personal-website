# 🚀 快速部署指南 - jiazhenpan.me

## 方案选择

### 推荐方案：GitHub Pages（免费、简单、可靠）

## 快速开始

### 1. 自动部署（推荐）

```bash
# 运行自动部署脚本
./deploy.sh
```

脚本会自动：
- 初始化Git仓库
- 上传文件到GitHub
- 提供后续配置指导

### 2. 手动部署

#### 步骤1：创建GitHub仓库
1. 访问 [GitHub](https://github.com)
2. 创建新仓库：`jiazhenpan-website`
3. 选择 "Public"

#### 步骤2：上传文件
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/jiazhenpan-website.git
git branch -M main
git push -u origin main
```

#### 步骤3：启用GitHub Pages
1. 仓库页面 → Settings → Pages
2. Source: "Deploy from a branch"
3. Branch: "main", Folder: "/ (root)"
4. 点击 "Save"

#### 步骤4：配置自定义域名
1. 在Pages设置中找到 "Custom domain"
2. 输入：`jiazhenpan.me`
3. 勾选 "Enforce HTTPS"
4. 点击 "Save"

#### 步骤5：配置DNS
在您的域名注册商处添加以下DNS记录：

**A记录（4条）：**
```
@ → 185.199.108.153
@ → 185.199.109.153
@ → 185.199.110.153
@ → 185.199.111.153
```

**CNAME记录（1条）：**
```
www → YOUR_USERNAME.github.io
```

## 域名注册商DNS配置示例

### GoDaddy
1. 登录GoDaddy账户
2. 进入 "My Products" → "DNS"
3. 找到 jiazhenpan.me
4. 点击 "Manage DNS"
5. 添加上述A记录和CNAME记录

### Namecheap
1. 登录Namecheap账户
2. 进入 "Domain List" → "Manage"
3. 点击 "Advanced DNS"
4. 添加上述记录

### 阿里云/腾讯云
1. 登录控制台
2. 进入域名管理
3. 找到 jiazhenpan.me
4. 点击 "解析设置"
5. 添加上述记录

## 验证部署

### 检查DNS解析
```bash
nslookup jiazhenpan.me
```

### 检查网站访问
- 等待5-30分钟（DNS传播时间）
- 访问 https://jiazhenpan.me
- 检查 https://www.jiazhenpan.me

## 更新网站

当您需要更新网站内容时：

```bash
# 修改文件后
git add .
git commit -m "Update content"
git push origin main
```

GitHub Pages会自动重新部署。

## 故障排除

### 网站无法访问
1. 检查DNS设置是否正确
2. 确认GitHub Pages已启用
3. 等待DNS传播（最多48小时）

### HTTPS证书问题
1. 确保在GitHub Pages中勾选了 "Enforce HTTPS"
2. 等待证书自动生成（可能需要几分钟）

### 图片无法显示
1. 检查图片路径是否正确
2. 确认图片文件已上传到GitHub

## 其他部署选项

### Netlify（推荐备选方案）
1. 访问 [Netlify](https://netlify.com)
2. 注册并连接GitHub
3. 选择您的仓库
4. 添加自定义域名：`jiazhenpan.me`

### Vercel（推荐备选方案）
1. 访问 [Vercel](https://vercel.com)
2. 注册并导入GitHub仓库
3. 添加自定义域名：`jiazhenpan.me`

## 联系支持

如果遇到问题：
- GitHub Pages文档：https://pages.github.com/
- GitHub Pages故障排除：https://docs.github.com/en/pages/getting-started-with-github-pages/troubleshooting-jekyll-build-errors-for-github-pages-sites

---

**🎉 恭喜！您的个人网站即将上线！**
