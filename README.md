# Jiazhen Pan - Personal Website

这是我的个人网站，展示我的研究、教学和团队信息。

## 本地开发

1. 克隆仓库：
```bash
git clone https://github.com/yourusername/jiazhenpan-website.git
cd jiazhenpan-website
```

2. 在浏览器中打开 `index.html` 文件即可预览网站。

## 部署到 GitHub Pages

### 步骤1：创建GitHub仓库

1. 访问 [GitHub](https://github.com) 并登录
2. 点击右上角的 "+" 按钮，选择 "New repository"
3. 仓库名称：`jiazhenpan-website`
4. 选择 "Public"
5. 点击 "Create repository"

### 步骤2：上传网站文件

在您的本地项目目录中运行以下命令：

```bash
# 初始化Git仓库
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "Initial commit"

# 添加远程仓库
git remote add origin https://github.com/yourusername/jiazhenpan-website.git

# 推送到GitHub
git branch -M main
git push -u origin main
```

### 步骤3：启用GitHub Pages

1. 在GitHub仓库页面，点击 "Settings" 标签
2. 在左侧菜单中找到 "Pages"
3. 在 "Source" 部分，选择 "Deploy from a branch"
4. 在 "Branch" 下拉菜单中选择 "main"，文件夹选择 "/ (root)"
5. 点击 "Save"

### 步骤4：配置自定义域名

1. 在GitHub Pages设置页面，找到 "Custom domain" 部分
2. 输入您的域名：`jiazhenpan.me`
3. 勾选 "Enforce HTTPS"
4. 点击 "Save"

### 步骤5：配置DNS

在您的域名注册商（如GoDaddy、Namecheap等）的DNS设置中添加以下记录：

**A记录：**
- 名称：`@`
- 值：`185.199.108.153`
- 值：`185.199.109.153`
- 值：`185.199.110.153`
- 值：`185.199.111.153`

**CNAME记录：**
- 名称：`www`
- 值：`yourusername.github.io`

### 步骤6：等待生效

DNS更改可能需要几分钟到48小时才能生效。您可以通过以下方式检查：

```bash
# 检查DNS解析
nslookup jiazhenpan.me
```

## 文件结构

```
website/
├── index.html          # 主页面
├── assets/
│   ├── css/
│   │   └── styles.css  # 样式文件
│   ├── js/
│   │   └── main.js     # JavaScript文件
│   └── img/            # 图片资源
└── README.md           # 说明文档
```

## 更新网站

当您需要更新网站内容时：

```bash
# 修改文件后
git add .
git commit -m "Update website content"
git push origin main
```

GitHub Pages会自动重新部署您的网站。

## 其他部署选项

### Netlify部署

1. 访问 [Netlify](https://netlify.com) 并注册账户
2. 点击 "New site from Git"
3. 选择GitHub并授权
4. 选择您的仓库
5. 在 "Build settings" 中：
   - Build command：留空
   - Publish directory：留空（因为这是静态网站）
6. 点击 "Deploy site"
7. 在 "Domain settings" 中添加自定义域名 `jiazhenpan.me`

### Vercel部署

1. 访问 [Vercel](https://vercel.com) 并注册账户
2. 点击 "New Project"
3. 导入您的GitHub仓库
4. 在项目设置中添加自定义域名 `jiazhenpan.me`

## 故障排除

### 常见问题

1. **网站无法访问**
   - 检查DNS设置是否正确
   - 确认GitHub Pages已启用
   - 等待DNS传播（最多48小时）

2. **图片无法显示**
   - 检查图片路径是否正确
   - 确认图片文件已上传到GitHub

3. **样式无法加载**
   - 检查CSS文件路径
   - 确认文件编码为UTF-8

### 联系支持

如果遇到问题，可以：
- 检查GitHub Pages的[官方文档](https://pages.github.com/)
- 查看GitHub Pages的[故障排除指南](https://docs.github.com/en/pages/getting-started-with-github-pages/troubleshooting-jekyll-build-errors-for-github-pages-sites)

## 许可证

此项目采用MIT许可证。

