# 🍲 今天吃什么？

<div align="center">

  <h1>
    <br>
    <img src="https://raw.githubusercontent.com/vueuse/vue-demi/master/assets/banner.png" alt="今天吃什么" width="400">
    <br>
    今天吃什么
    <br>
  </h1>
  
  ![Version](https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000)
  ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
  ![Vue](https://img.shields.io/badge/Vue-3.x-green.svg)
  ![TypeScript](https://img.shields.io/badge/TypeScript-4.x-blue.svg)
  ![Vite](https://img.shields.io/badge/Vite-4.x-purple.svg)
  
</div>

> 🍜 一个帮你解决"吃什么"难题的简单Vue应用，支持随机推荐食物，帮助纠结的你快速决定今天吃什么。

<p align="center">
  <img src="https://user-images.githubusercontent.com/5889006/111046979-0f2eea00-845b-11eb-80ca-717a9a838e2c.gif" width="600" alt="项目演示" />
</p>

## ✨ 功能介绍

- 🎮 点击"开始"按钮随机推荐食物，酷炫的抽奖动画效果
- ⏱️ 支持手动停止或5秒自动停止随机选择
- 🔄 可以点击"换一个"重新推荐
- 📝 自动记录历史推荐结果
- 💻 响应式设计，移动端适配良好
- 🎨 简洁直观的用户界面
- 🍕 可爱的浮动食物图标背景
- 👋 "联系博主"功能，扫码添加好友
- 🥗 "好好吃饭"温馨提示与祝福语

## 🖥️ 预览
## 🛠️ 技术栈

- ⚡ Vue 3 (Composition API)
- 🔷 TypeScript
- 📦 Vite
- 🎭 原生CSS动画

## 🚀 本地运行

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build

# 使用deploy.sh部署到GitHub Pages
sh deploy.sh
```

## 📋 部署指南

### GitHub Pages 部署

1. 在你的仓库中，创建`deploy.sh`文件:

```bash
#!/usr/bin/env sh

# 构建
npm run build

# 进入构建文件夹
cd dist

# 如果你要部署到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# 部署到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:<USERNAME>/<REPO>.git main:gh-pages

cd -
```

2. 修改`vite.config.ts`，添加正确的base路径:

```ts
export default defineConfig({
  base: '/what-to-eat/',
  // 其他配置...
})
```

## 🔧 配置说明

### 📱 修改食物列表

在 `src/App.vue` 文件中找到并修改 `foodList` 数组：

```js
const foodList = reactive([
  '烤肉', '火锅', '炸鸡', '寿司', 
  // ... 添加你喜欢的食物
]);
```

### 🎨 自定义样式

主题颜色和动画效果可在 `src/App.vue` 的样式部分修改：

```css
:root {
  --primary-color: #3eaf7c; /* 主题色 */
  --animation-duration: 0.1s; /* 抽选动画速度 */
}
```

### ⏱️ 修改自动停止时间

在 `src/App.vue` 中找到 `startSelection` 函数：

```js
// 修改数值来调整自动停止时间（毫秒）
setTimeout(() => {
  if (isSelecting.value) {
    stopSelection();
  }
}, 5000); // 这里可以修改，默认5秒
```

## 📸 截图

<div align="center">
  <p>🖼️ 部署应用后，在这里添加实际应用截图</p>
</div>

## 📝 开源协议

MIT License &copy; 2023

## 🤝 参与贡献

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## ❓ 常见问题 (FAQ)

<details>
<summary>🔄 如何添加新的食物选项？</summary>
<br>
打开 <code>src/App.vue</code> 文件，找到 <code>foodList</code> 数组，添加你喜欢的食物即可：

```js
const foodList = reactive([
  '烤肉', '火锅', '炸鸡', '寿司', 
  // 在这里添加你的食物
  '麻辣烫', '汉堡', '披萨'
]);
```
</details>

<details>
<summary>🎨 如何修改颜色和主题？</summary>
<br>
在 <code>src/App.vue</code> 的 <code>style</code> 部分修改 CSS 变量：

```css
:root {
  --primary-color: #3eaf7c; /* 主题色 */
  --text-color: #2c3e50; /* 文字颜色 */
  --background-color: #f8f8f8; /* 背景色 */
}
```
</details>

<details>
<summary>📱 如何在手机上使用？</summary>
<br>
应用已适配移动端，你可以直接通过手机浏览器访问部署后的网址即可使用。
</details>

<details>
<summary>🚀 如何部署到自己的服务器？</summary>
<br>
运行 <code>npm run build</code> 生成 <code>dist</code> 目录，然后将整个目录上传到你的服务器即可。
</details>

## 📊 项目状态

![GitHub stars](https://img.shields.io/github/stars/yourusername/what-to-eat?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/what-to-eat?style=social)

---

<p align="center">
  用 ❤️ 制作 | 2023
</p>
