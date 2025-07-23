#!/usr/bin/env sh

# 发生错误时终止
set -e

# 构建
echo "开始构建应用..."
npm run build

# 进入构建文件夹
cd dist

# 如果你要部署到自定义域名
# echo 'www.example.com' > CNAME

echo "正在初始化Git仓库..."
git init
git add -A
git commit -m 'deploy: 部署到GitHub Pages'

# 部署到 https://<USERNAME>.github.io/<REPO>
# 将下面的 <USERNAME> 和 <REPO> 替换为你的GitHub用户名和仓库名
echo "正在推送到GitHub Pages分支..."
git push -f git@github.com:<USERNAME>/what-to-eat.git main:gh-pages

echo "部署完成！"
cd - 