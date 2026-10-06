# Py启航 / PyPath

一套把原「Python 零基础学习平台」整合进网站的学习站点。

## 快速打开

双击 `start-site.bat`。

它会：

1. 优先使用 Node.js 启动本地静态服务器，没有 Node.js 就尝试 Python
2. 自动用默认浏览器打开 `http://127.0.0.1:8788/`

> 推荐用这种方式打开。直接双击 `index.html` 也能看首页，但学习平台的 iframe、剪贴板和 Pyodide 在本地服务器下更稳定。

## 网站结构

```text
pyqihang-site/
├─ index.html                          # 首页
├─ learn.html                          # 学习平台入口（iframe）
├─ textbook.html                       # 课程讲义入口（iframe）
├─ 404.html                            # 404 页面
├─ start-site.bat                      # 本地启动脚本
├─ server.js                           # 无依赖的 Node 静态服务器
├─ site.webmanifest                    # PWA / 图标信息
├─ robots.txt                          # 搜索引擎规则
├─ README.md
├─ assets/
│  ├─ css/site.css                     # 外层网站样式
│  ├─ js/site.js                       # 动效和年份
│  └─ img/
│     ├─ pyqihang-logo.svg             # Py启航 Logo
│     ├─ platform-icon.png             # 原平台图标
│     └─ favicon.ico
└─ platform/
   ├─ python-learning-platform.html    # 原学习平台，完整保留
   ├─ python-course-textbook.html      # 原课程讲义，完整保留
   ├─ index.html                       # 平台目录跳转页
   └─ 原平台说明.txt
```

## 原平台说明

- 12 章、62 节课、66 道自动判分练习
- 自测考试、错题本、速查表、术语表、学习计划
- 第一次点「运行」需要联网下载 Python 引擎（约 10MB），之后浏览器会缓存
- 学习进度存放在浏览器本地，可导出/导入 JSON 备份
- 已修复原页面中 `__LESSONS__` / `__EXERCISES__` 占位符显示问题

## 以后换域名

域名确定后，通常只需要：

1. 把整个 `pyqihang-site` 文件夹上传到静态托管
2. 在托管平台绑定域名
3. 把站点名、页脚和 `site.webmanifest` 里的名称改成最终名称
4. 如果需要 SEO，再把 `robots.txt` 和站点地图补上完整域名

当前网站不需要后端，任何静态托管都可以。

## 最终网址名

暂定正式域名：`pypath.cn`。

备选：`pyqihang.cn`。

> 域名是否已注册仍需在注册商页面确认；本机 DNS 查询显示 `pypath.com` 和 `pypath.net` 已有解析记录，因此没有选这两个。

## 其他候选域名

- `pyqihang.com`
- `pyqihang.cn`
- `pypath.cn`
- `pypath.net`

这些只是候选字符串，不代表已经注册或可用；域名可用性需要另外查询。

## 修改站名

当前站名：

- 中文：`Py启航`
- 英文 / 网址名：`PyPath`

主要出现位置：

- `index.html`
- `learn.html`
- `textbook.html`
- `site.webmanifest`
- `assets/img/pyqihang-logo.svg`

## 注意事项

原平台 HTML 里的课程数据和运行逻辑没有改动，只替换了显示占位符。外层网站把它放进首页、导航和学习平台入口里。

如果需要完全离线运行 Python，需要把 Pyodide 引擎也本地化；目前原平台会从 CDN 加载 Python 引擎。
## 部署方案

暂定使用 **Cloudflare Pages**：

- 站址 / 域名：`https://pypath.cn/`
- 托管：Cloudflare Pages
- 类型：纯静态网站，不需要后端
- 部署目录：当前 `pyqihang-site` 整个文件夹
- 配置文件：`wrangler.toml`、`_headers`

如果使用 Wrangler 部署：

```powershell
npm install -g wrangler
wrangler login
wrangler pages deploy . --project-name=pypath
```

部署完成后，在 Cloudflare Pages 的「Custom domains」里绑定：

```text
pypath.cn
```

域名注册和 Cloudflare 账号需要站点所有者本人操作，因为涉及实名、付款和账号权限。
## GitHub Pages 部署

已准备 GitHub Actions 工作流：

```text
.github/workflows/pages.yml
```

预计仓库名：

```text
pypath
```

临时 GitHub Pages 地址：

```text
https://2398532573-a11y.github.io/pyqihang/
```

首次推送后，在仓库：

1. 打开 `Settings`
2. 进入 `Pages`
3. 把 `Build and deployment` 的 `Source` 设为 `GitHub Actions`

之后每次推送到 `main` 分支，Actions 会自动重新部署。

如果本机安装了 GitHub CLI 并已登录，可以在站点目录执行：

```powershell
gh repo create pyqihang --public --source=. --remote=origin --push
```

### 以后绑定 pypath.cn

GitHub Pages 也支持自定义域名：

1. 仓库 `Settings` → `Pages` → `Custom domain`
2. 填入 `pypath.cn`
3. 按 GitHub 提示到域名注册商添加 DNS 记录
4. 开启 `Enforce HTTPS`

自定义域名绑定后，再把 `robots.txt` 和 `sitemap.xml` 里的临时地址替换成 `https://pypath.cn/`。