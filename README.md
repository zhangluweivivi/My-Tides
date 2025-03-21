# 我的潮汐 - 女性健康应用

"我的潮汐"是一款根据月经周期为女性提供健康建议的网页应用程序。它能够基于用户当前所处的周期阶段，提供个性化的健身、饮食和放松建议。

## 主要功能

### 1. 个性化周期跟踪
- 跟踪和预测月经周期
- 基于周期阶段提供个性化健康建议
- 记录各种周期相关症状和体验

### 2. 用户初始化问卷
- 收集用户的首次使用信息：上次月经时间、运动和饮食偏好、身体数据等
- 支持与Apple Health数据同步(仅iOS设备)
- 为应用提供个性化配置基础

### 3. 自适应健身建议
- 根据周期阶段推荐适合的运动类型
- 提供有针对性的锻炼视频和指导
- 调整锻炼强度以匹配用户能量水平

### 4. 营养与饮食指导
- 基于周期阶段的饮食建议
- 解决特定周期阶段的营养需求
- 提供食谱和饮食计划

### 5. 放松与情绪管理
- 提供心理健康和放松技巧
- 针对不同周期阶段的冥想和减压方法
- 情绪追踪和洞察

### 6. 健康数据可视化
- 图表展示周期、情绪、症状和健康趋势
- 睡眠质量分析
- 活动统计和分布图表
- 生成每周健康报告

### 7. 云数据存储与同步
- 用户账户系统(注册/登录)
- 跨设备数据同步
- 安全的健康数据存储

## 技术实现

项目使用纯JavaScript、HTML和CSS构建，无需任何框架，结构如下：

- **index.html**: 主应用入口
- **src/app.js**: 应用程序主逻辑
- **src/utils/**: 工具模块
  - **cycleCalculator.js**: 周期计算器
  - **cloudStorage.js**: 云存储和同步功能
  - **dataVisualization.js**: 数据可视化工具
- **src/screens/**: 页面模块
  - **myTides.js**: 主页面
  - **workout.js**: 运动页面
  - **diet.js**: 饮食页面
  - **relaxation.js**: 放松页面
  - **data.js**: 数据页面
  - **quiz.js**: 用户初始化问卷
  - **login.js**: 登录和注册页面
- **src/data/**: 数据模型
- **src/styles/**: 样式文件
- **src/assets/**: 图像和媒体文件

## 如何运行

1. 克隆或下载本仓库
2. 使用简单的HTTP服务器运行项目：
   ```
   python -m http.server
   ```
3. 在浏览器中访问 `http://localhost:8000`

## 使用的库和资源

- **Chart.js**: 用于数据可视化
- **Firebase**: 用于用户认证和数据存储
- **Material Icons**: 用于界面图标

## 未来计划

- 添加更多精细的周期预测算法
- 实现完整的Apple Health集成
- 添加实际的锻炼视频和冥想音频
- 开发移动应用版本
- 添加社区和用户反馈功能

## 注意事项

- Firebase配置需要替换为实际的Firebase项目信息
- 目前项目使用模拟数据进行展示
- 此项目仅作为原型和概念验证，不应被视为医疗建议

## 许可证

本项目采用MIT许可证。 