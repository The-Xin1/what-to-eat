<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
// 导入二维码图片
import qrCodeImage from './image/01.jpg';

// 食物列表
const foodList = reactive([
  // 中式炒菜/家常菜
  '麻辣香锅', '火锅', '烤鱼', '川菜', '湘菜', '粤菜', '东北菜', '西北菜', 
  '红烧肉', '糖醋排骨', '鱼香肉丝', '宫保鸡丁', '麻婆豆腐', '水煮肉片', '回锅肉',
  '酸菜鱼', '东坡肉', '小龙虾', '清蒸鱼', '爆炒虾', '干锅鸡', '干锅肥肠',
  '香辣蟹', '葱爆羊肉', '家常豆腐', '锅包肉', '溜肉段', '京酱肉丝',
  
  // 中式面点/小吃
  '小笼包', '炒饭', '炒面', '盖浇饭', '水饺', '馄饨', '面条', '米粉',
  '煎饼果子', '肉夹馍', '烧烤', '臭豆腐', '烤冷面', '麻辣烫', 
  '酸辣粉', '螺蛳粉', '冒菜', '便当', '卤肉饭', '沙县小吃', '煲仔饭',
  '烧麦', '叉烧包', '生煎包', '锅贴', '葱油饼', '羊肉泡馍', '凉皮',
  '热干面', '担担面', '刀削面', '兰州拉面', '油泼面', '炸酱面', '过桥米线',
  '重庆小面', '肠粉', '云吞面', '车仔面', '炒河粉', '豆花', '豆浆油条',
  
  // 西式料理
  '牛排', '意大利面', '披萨', '汉堡', '三明治', '沙拉',
  '烤全鸡', '烤肋排', '奶酪焗饭', '鸡翅', '薯条', '法式蜗牛',
  '龙虾', '海鲜饭', '牛肉Wellington', '意式烩饭', '千层面',
  
  // 日式料理
  '寿司', '拉面', '天妇罗', '烤肉', '刺身', '章鱼小丸子',
  '亲子丼', '牛丼', '猪排饭', '咖喱饭', '乌冬面', '寿喜锅',
  '炸猪排', '烤鳗鱼', '冷荞麦面', '日式火锅', '关东煮',
  
  // 韩式料理
  '石锅拌饭', '部队火锅', '冷面', '韩式炸鸡', '烤肉', '泡菜汤',
  '紫菜包饭', '辣炒年糕', '参鸡汤', '海鲜煎饼', '韩式拌饭',
  
  // 东南亚料理
  '咖喱鸡', '冬阴功汤', '椰汁饭', '菠萝炒饭', '海南鸡饭', '沙爹',
  '叻沙', '越南河粉', '越南春卷', '泰式炒河粉', '印度飞饼', '印度咖喱',
  
  // 快餐
  '肯德基', '麦当劳', '德克士', '必胜客', '华莱士', '真功夫',
  '永和大王', '吉野家', '赛百味', '五芳斋', '蜜雪冰城', '书亦烧仙草',
  
  // 早餐选择
  '包子', '油条', '豆浆', '茶叶蛋', '手抓饼', '灌汤包',
  '粢饭团', '三明治', '煎饼', '鸡蛋灌饼', '豆腐脑', '稀饭',
  
  // 海鲜类
  '蒜蓉扇贝', '清蒸大闸蟹', '辣炒花甲', '香辣虾', '葱姜炒蟹',
  '豉汁蒸排骨', '干锅鱿鱼', '椒盐虾', '麻辣小龙虾', '蒜香生蚝',
  
  // 奶茶专区
  '珍珠奶茶', '波霸奶茶', '椰果奶茶', '芋圆奶茶', '红豆奶茶', '布丁奶茶',
  '芝士奶盖茶', '水果茶', '焦糖奶茶', '巧克力奶茶', '抹茶拿铁', '草莓奶茶',
  '芒果奶茶', '柠檬茶', '乌龙奶茶', '茉莉奶茶', '玫瑰奶茶', '椰香奶茶',
  '桂花乌龙', '金桔柠檬', '葡萄柚绿茶', '百香果茶', '杨枝甘露', '芝士水果茶',
  '桃桃乌龙', '青提乌龙', '多肉葡萄', '茶百道', '一点点', '贡茶',
  '益禾堂', 'COCO都可', '喜茶', '奈雪的茶', '茶颜悦色', '霸王茶姬',
  '乐乐茶', '蜜雪冰城奶茶', '古茗', '沪上阿姨', '鹿角巷', '甘茗城',
  '蜜果', '黑泷堂', '七分甜', '柠檬工坊', '茶马史朗', '1點點', 
  '乐咕噜', '阿水大杯茶', '百果园', '丸摩堂', '瑞幸咖啡奶茶'
]);

// 当前展示的食物
const currentFood = ref('');

// 是否正在随机选择
const isSelecting = ref(false);

// 是否已经选择了食物
const hasSelected = ref(false);

// 是否显示二维码弹窗
const showQRCode = ref(false);

// 是否显示祝福弹窗
const showWishMessage = ref(false);

// 随机选择间隔
let interval: number | null = null;

// 自动停止计时器
let autoStopTimer: number | null = null;

// 历史记录
const history = ref<string[]>([]);

// 加载历史记录
onMounted(() => {
  const savedHistory = localStorage.getItem('foodHistory');
  if (savedHistory) {
    try {
      history.value = JSON.parse(savedHistory);
    } catch (e) {
      console.error('无法解析历史记录', e);
    }
  }
});

// 开始随机选择
const startSelection = () => {
  isSelecting.value = true;
  hasSelected.value = false;
  
  // 清除之前的定时器
  if (interval) {
    clearInterval(interval);
  }
  
  // 清除自动停止计时器
  if (autoStopTimer) {
    clearTimeout(autoStopTimer);
  }
  
  // 设置5秒后自动停止
  autoStopTimer = window.setTimeout(() => {
    stopSelection();
  }, 1000);
  
  // 固定速度抽选
  interval = window.setInterval(() => {
    // 随机选择一个食物
    const randomIndex = Math.floor(Math.random() * foodList.length);
    currentFood.value = foodList[randomIndex];
  }, 80); // 固定80ms的速度
};

// 停止选择
const stopSelection = () => {
  if (interval) {
    clearInterval(interval);
    interval = null;
  }
  
  // 清除自动停止计时器
  if (autoStopTimer) {
    clearTimeout(autoStopTimer);
    autoStopTimer = null;
  }
  
  isSelecting.value = false;
  hasSelected.value = true;
  
  // 添加到历史记录
  if (currentFood.value) {
    history.value = [currentFood.value, ...history.value.slice(0, 9)];
    localStorage.setItem('foodHistory', JSON.stringify(history.value));
  }
};

// 重新选择
const reselect = () => {
  startSelection();
};

// 显示二维码
const toggleQRCode = () => {
  showQRCode.value = !showQRCode.value;
  // 关闭另一个弹窗
  if (showQRCode.value) {
    showWishMessage.value = false;
  }
};

// 显示祝福弹窗
const toggleWishMessage = () => {
  showWishMessage.value = !showWishMessage.value;
  // 关闭另一个弹窗
  if (showWishMessage.value) {
    showQRCode.value = false;
  }
};
</script>

<template>
  <div class="app-container">
    <!-- 食物小图标背景 -->
    <div class="food-icons">
      <div class="food-icon icon1"></div>
      <div class="food-icon icon2"></div>
      <div class="food-icon icon3"></div>
      <div class="food-icon icon4"></div>
      <div class="food-icon icon5"></div>
      <div class="food-icon icon6"></div>
      <div class="food-icon icon7"></div>
    </div>
    
    <div class="home-page">
      <div class="center-content">
        <!-- 选择前的状态 -->
        <div v-if="!isSelecting && !hasSelected">
          <h1 class="title">今天吃什么</h1>
          <button class="start-btn" @click="startSelection">开始</button>
        </div>
        
        <!-- 选择中的状态 -->
        <div v-if="isSelecting" class="selecting">
          <h1 class="title selecting-text">{{ currentFood }}</h1>
          <button class="stop-btn" @click="stopSelection">停下</button>
        </div>
        
        <!-- 选择结果 -->
        <div v-if="hasSelected" class="result">
          <h1 class="title result-text">{{ currentFood }}</h1>
          <button class="retry-btn" @click="reselect">换一个</button>
        </div>
      </div>
      
      <div class="bottom-actions">
        <div class="left-action">
          <button class="friend-btn" @click="toggleQRCode">
            <i class="icon-message"></i>
            联系博主
          </button>
        </div>
        <div class="right-action">  
          <button class="custom-btn" @click="toggleWishMessage">
            <i class="icon-edit"></i>
            好好吃饭
          </button>
        </div>
      </div>
    </div>

    <!-- 二维码弹窗 -->
    <div v-if="showQRCode" class="qrcode-modal" @click="toggleQRCode">
      <div class="qrcode-container" @click.stop>
        <div class="qrcode-content">
          <div class="qrcode-image">
            <!-- 使用提供的二维码图片 -->
            <img :src="qrCodeImage" alt="联系博主二维码" />
          </div>
          <div class="qrcode-title">扫一扫上面的二维码图案，加我为朋友</div>
          <button class="close-btn" @click="toggleQRCode">关闭</button>
        </div>
      </div>
    </div>

    <!-- 祝福弹窗 -->
    <div v-if="showWishMessage" class="wish-modal" @click="toggleWishMessage">
      <div class="wish-container" @click.stop>
        <div class="wish-content">
          <div class="wish-icon">🍽️</div>
          <h2 class="wish-title">好好吃饭</h2>
          <p class="wish-message">人生匆匆，不要忘记好好吃饭</p>
          <p class="wish-message">一日三餐，按时定量</p>
          <p class="wish-message">营养均衡，健康常伴</p>
          <p class="wish-message">吃饭是一生中最重要的事情之一</p>
          <button class="close-btn" @click="toggleWishMessage">我会的</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
}

html, body {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
}

body {
  background-color: #ffffff;
  color: #333;
  overflow: hidden;
}

#app {
  height: 100vh;
  width: 100vw;
}

.app-container {
  position: relative;
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  overflow: hidden;
}

/* 食物图标背景 */
.food-icons {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  overflow: hidden;
}

.food-icon {
  position: absolute;
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.15;
}

.icon1 {
  top: 5%;
  right: 10%;
  width: 100px;
  height: 100px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FFCC80" d="M64,384h384v-42.67H64V384z M72.53,144h366.94c-5.44-29.29-23.33-55.25-50.13-74.67 C352.15,43.25,302.19,32,256,32s-96.15,11.25-133.33,37.33C96,90.75,77.97,116.71,72.53,144z M437.33,170.67H74.67v128h362.67 V170.67z"/></svg>');
  animation: float 8s ease-in-out infinite;
}

.icon2 {
  bottom: 20%;
  left: 15%;
  width: 80px;
  height: 80px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FFA726" d="M388.94,151.56c-14.08-37.33-50.13-62.08-90.27-62.08c-14.08,0-27.31,2.88-39.68,8.61 c-18.24-38.4-57.28-64-101.33-64C84.74,34.09,32,86.83,32,149.75c0,23.47,7.04,45.67,20.27,64.21 C20.48,230.4,0,264.75,0,303.15C0,372.69,56.75,429.44,126.29,429.44c32.64,0,63.57-12.48,86.72-34.13 c18.24,10.88,39.04,16.85,60.8,16.85c65.92,0,119.47-53.55,119.47-119.47c0-18.24-4.27-35.84-12.16-52.05 c34.56-5.97,60.8-36.05,60.8-72.11C441.92,184.21,419.84,155.15,388.94,151.56z"/></svg>');
  animation: float 10s ease-in-out infinite;
  animation-delay: 1s;
}

.icon3 {
  top: 30%;
  left: 10%;
  width: 70px;
  height: 70px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FFECB3" d="M469.33,106.67H42.67C19.2,106.67,0,125.87,0,149.33v213.33c0,23.47,19.2,42.67,42.67,42.67h426.67 c23.47,0,42.67-19.2,42.67-42.67V149.33C512,125.87,492.8,106.67,469.33,106.67z"/></svg>');
  animation: float 7s ease-in-out infinite;
  animation-delay: 2s;
}

.icon4 {
  bottom: 10%;
  right: 15%;
  width: 90px;
  height: 90px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23F9A825" d="M256,85.33c-94.1,0-170.67,76.56-170.67,170.67S161.9,426.67,256,426.67S426.67,350.1,426.67,256 S350.1,85.33,256,85.33z M256,384c-70.57,0-128-57.43-128-128s57.43-128,128-128s128,57.43,128,128S326.57,384,256,384z"/></svg>');
  animation: float 12s ease-in-out infinite;
}

.icon5 {
  top: 15%;
  left: 20%;
  width: 60px;
  height: 60px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FF7043" d="M418.13,139.52C395.92,61.01,331.89,0,256,0S116.08,61.01,93.87,139.52C41.92,154.45,0,201.39,0,256 c0,70.69,57.31,128,128,128c32.43,0,62.93-12.48,86.4-34.13C230.4,360.75,243.84,368,256,368s25.6-7.25,41.6-18.13 c23.47,21.65,53.97,34.13,86.4,34.13c70.69,0,128-57.31,128-128C512,201.39,470.08,154.45,418.13,139.52z"/></svg>');
  animation: float 9s ease-in-out infinite;
  animation-delay: 0.5s;
}

.icon6 {
  bottom: 25%;
  right: 5%;
  width: 75px;
  height: 75px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FFCC80" d="M64,128h384v256H64V128z"/></svg>');
  animation: float 11s ease-in-out infinite;
  animation-delay: 1.5s;
}

.icon7 {
  top: 40%;
  right: 25%;
  width: 65px;
  height: 65px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23FFC107" d="M480,256c0,123.71-100.29,224-224,224S32,379.71,32,256S132.29,32,256,32S480,132.29,480,256z"/></svg>');
  animation: float 8.5s ease-in-out infinite;
  animation-delay: 2.5s;
}

@keyframes float {
  0% {
    transform: translateY(0) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(5deg);
  }
  100% {
    transform: translateY(0) rotate(0deg);
  }
}

/* 主页样式 */
.home-page {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 100%;
  height: 100%;
  text-align: center;
  z-index: 1;
}

.center-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.title {
  font-size: 60px;
  font-weight: bold;
  margin-bottom: 50px;
}

.start-btn {
  background-color: #FF9800;
  color: white;
  border: none;
  border-radius: 50px;
  padding: 15px 70px;
  font-size: 24px;
  cursor: pointer;
  transition: all 0.3s;
}

.start-btn:hover {
  background-color: #F57C00;
  transform: scale(1.05);
}

.bottom-actions {
  display: flex;
  justify-content: space-between;
  width: 100%;
  padding: 20px 40px;
  margin-bottom: 20px;
}

.left-action {
  text-align: left;
}

.right-action {
  text-align: right;
}

.friend-btn, .custom-btn {
  background: transparent;
  border: none;
  padding: 10px 20px;
  font-size: 18px;
  display: flex;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s;
}

.friend-btn {
  color: #2196F3;
}

.custom-btn {
  color: #FF9800;
}

.icon-user, .icon-edit {
  margin-right: 8px;
}

.icon-user:before {
  content: "👥";
}

.icon-edit:before {
  content: "✏️";
}

/* 更新图标样式 */
.icon-message::before {
  content: "\1F4AC"; /* 💬 消息气泡图标 */
  font-size: 18px;
  margin-right: 5px;
}

/* 选择中的效果 */
.selecting {
  text-align: center;
}

.selecting-text {
  font-size: 70px;
  animation: pulse 1s infinite;
}

.spinner {
  width: 50px;
  height: 50px;
  margin: 25px auto;
  border: 5px solid rgba(255, 152, 0, 0.3);
  border-radius: 50%;
  border-top-color: #FF9800;
  animation: spin 1s ease-in-out infinite;
}

.result {
  text-align: center;
}

.result-text {
  font-size: 70px;
  margin-bottom: 30px;
  animation: popIn 0.5s;
}

.retry-btn {
  background-color: #FF9800;
  color: white;
  border: none;
  border-radius: 50px;
  padding: 12px 40px;
  font-size: 22px;
  cursor: pointer;
  transition: all 0.3s;
}

.retry-btn:hover {
  background-color: #F57C00;
  transform: scale(1.05);
}

.stop-btn {
  background-color: #FF5252;
  color: white;
  border: none;
  border-radius: 50px;
  padding: 15px 70px;
  font-size: 24px;
  cursor: pointer;
  transition: all 0.3s;
  margin-top: 20px;
}

.stop-btn:hover {
  background-color: #D32F2F;
  transform: scale(1.05);
}

/* 动画效果 */
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.6;
  }
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes popIn {
  0% {
    transform: scale(0.9);
    opacity: 0;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* 二维码弹窗样式 */
.qrcode-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}

.qrcode-container {
  background-color: white;
  border-radius: 16px;
  padding: 30px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  max-width: 90%;
  width: 380px;
}

.qrcode-content {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.qrcode-image {
  width: 300px;
  height: 300px;
  margin-bottom: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.qrcode-image img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.qrcode-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 20px;
  color: #666;
  text-align: center;
}

.close-btn {
  background-color: #FF9800;
  color: white;
  border: none;
  border-radius: 50px;
  padding: 8px 24px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s;
}

.close-btn:hover {
  background-color: #F57C00;
  transform: scale(1.05);
}

/* 祝福弹窗样式 */
.wish-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}

.wish-container {
  background-color: white;
  border-radius: 16px;
  padding: 30px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  max-width: 90%;
  width: 380px;
}

.wish-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.wish-icon {
  font-size: 60px;
  margin-bottom: 20px;
}

.wish-title {
  font-size: 28px;
  font-weight: bold;
  margin-bottom: 20px;
  color: #FF9800;
}

.wish-message {
  font-size: 18px;
  color: #666;
  margin-bottom: 10px;
  line-height: 1.6;
}

/* 响应式样式 */
@media (max-width: 768px) {
  .home-page {
    width: 90%;
    padding: 15px;
  }
  
  .title {
    font-size: 28px;
    margin-bottom: 20px;
  }
  
  .start-btn, .stop-btn, .retry-btn {
    font-size: 18px;
    padding: 10px 30px;
  }
  
  .selecting-text, .result-text {
    font-size: 28px;
  }
  
  .bottom-actions {
    flex-direction: row;
    justify-content: center;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 30px;
  }
  
  .left-action, .right-action {
    width: 100%;
    text-align: center;
  }
  
  .friend-btn, .custom-btn {
    width: 80%;
    font-size: 16px;
  }
  
  /* 调整弹窗大小 */
  .qrcode-container, .wish-container {
    width: 90%;
    max-width: 320px;
    padding: 20px;
  }
  
  .qrcode-image {
    width: 250px;
    height: 250px;
  }
  
  .qrcode-title, .wish-title {
    font-size: 18px;
  }
  
  .wish-message {
    font-size: 16px;
  }
  
  /* 缩小图标尺寸 */
  .food-icon {
    width: 30px;
    height: 30px;
  }
}

/* 超小屏幕设备 */
@media (max-width: 375px) {
  .title {
    font-size: 24px;
  }
  
  .selecting-text, .result-text {
    font-size: 24px;
  }
  
  .start-btn, .stop-btn, .retry-btn {
    font-size: 16px;
    padding: 8px 25px;
  }
  
  .qrcode-image {
    width: 220px;
    height: 220px;
  }
}
</style>
