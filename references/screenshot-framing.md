# 截图适配指南（Screenshot Framing）

本文档定义：如何处理数据图表截图的美化，使其适配 Data Deck 的视觉风格。

---

## 适用场景

- 用户提供了 BI 工具、Excel、网页等截图
- 需要将截图美化后插入 PPT
- 截图需要统一风格和比例

---

## 截图分类

### 1. 数据图表截图
- 来源：BI 工具（Tableau、PowerBI、Metabase 等）
- 特点：包含图表、数据、标签
- 处理：保留数据，美化样式

### 2. 网页截图
- 来源：网页、Dashboard、管理后台
- 特点：包含 UI 元素、文字、按钮
- 处理：裁剪无关元素，保留核心内容

### 3. 应用截图
- 来源：App、软件界面
- 特点：包含界面元素、数据
- 处理：裁剪状态栏、导航栏，保留内容区

---

## 处理流程

### Step 1: 评估截图质量

| 质量 | 处理方式 |
|------|----------|
| 高清（≥1600px 宽） | 直接使用，调整比例 |
| 中等（800-1600px） | 裁剪 + 优化 |
| 低清（<800px） | 建议重新截图或使用 AI 生成 |

### Step 2: 选择比例

| 用途 | 推荐比例 | 说明 |
|------|----------|------|
| 全屏展示 | 16:9 | 主视觉、大图 |
| 图文混排 | 16:10 或 4:3 | 左文右图 |
| 数据大字报 | 21:9 | 宽屏数据展示 |
| 对比展示 | 1:1 | Before/After |

### Step 3: 美化处理

#### 3.1 添加背景
- 使用当前主题的 `--bg-secondary` 作为背景色
- 添加 1px 边框（`--border`）
- 无圆角（商务汇报风格）或 6px 圆角（数据科技风格）

#### 3.2 调整尺寸
- 容器宽度：100%
- 容器高度：根据比例自适应
- 图片：`object-fit: contain` 或 `object-fit: cover`

#### 3.3 添加标注
- 标题：图表名称
- 说明：数据来源、时间范围
- 强调：关键数据点

---

## 代码模板

### 基础截图容器

```html
<div class="screenshot-container">
  <img src="screenshots/chart-01.png" alt="销售趋势图" class="screenshot-img">
  <div class="screenshot-caption">
    <span class="caption-title">销售趋势</span>
    <span class="caption-source">数据来源：BI 系统</span>
  </div>
</div>
```

### CSS 样式

```css
.screenshot-container{
  background:var(--bg-secondary);
  border:1px solid var(--border);
  border-radius:var(--radius);
  padding:16px;
  display:flex;
  flex-direction:column;
  gap:12px;
}
.screenshot-img{
  width:100%;
  height:auto;
  object-fit:contain;
}
.screenshot-caption{
  display:flex;
  justify-content:space-between;
  align-items:center;
  font-size:12px;
  color:var(--text-muted);
}
.caption-title{
  font-weight:500;
  color:var(--text-secondary);
}
```

### 带强调的截图

```html
<div class="screenshot-container">
  <div class="screenshot-badge">关键数据</div>
  <img src="screenshots/dashboard-01.png" alt="Dashboard" class="screenshot-img">
  <div class="screenshot-caption">
    <span class="caption-title">运营 Dashboard</span>
    <span class="caption-source">2026-05</span>
  </div>
</div>
```

### CSS 强调样式

```css
.screenshot-badge{
  position:absolute;top:12px;right:12px;
  background:var(--accent);color:#fff;
  font-size:11px;font-weight:600;
  padding:4px 8px;
  text-transform:uppercase;
  letter-spacing:.05em;
}
.screenshot-container{
  position:relative;
}
```

---

## 常见问题

### Q: 截图模糊怎么办？
A: 建议重新截图，确保宽度 ≥ 1600px。如果无法重新截图，可以使用 AI 图片生成工具重新生成。

### Q: 截图比例不协调？
A: 使用 CSS `aspect-ratio` 或 `padding-top` 技术强制比例：
```css
.screenshot-wrapper{
  aspect-ratio:16/9;
  overflow:hidden;
}
.screenshot-wrapper img{
  width:100%;height:100%;
  object-fit:cover;
}
```

### Q: 截图有水印怎么办？
A: 使用图片编辑工具裁剪或遮盖水印，或者使用 AI 图片生成工具重新生成类似图表。

### Q: 多张截图如何统一风格？
A: 
1. 统一比例（全部 16:9 或全部 1:1）
2. 统一边距和边框
3. 统一标注格式
4. 使用相同的背景色

---

## 最佳实践

1. **优先重新截图**：模糊截图影响整体质量
2. **裁剪无关内容**：只保留核心数据区域
3. **统一比例**：同一页面的截图保持相同比例
4. **添加标注**：说明数据来源和时间范围
5. **测试显示效果**：在不同设备上检查截图显示

---

## 与 Data Deck 集成

### 在 Slide 中使用截图

```html
<section class="slide">
  <div class="chrome">
    <div>数据对比</div>
    <div>05 / 10</div>
  </div>
  <div class="slide-title" data-anim>系统对比</div>
  <div class="slide-subtitle" data-anim>新旧系统界面对比</div>
  <div class="chart-row cols-2" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-title">旧系统</div>
      <div class="chart-area">
        <div class="screenshot-container">
          <img src="screenshots/old-system.png" alt="旧系统" class="screenshot-img">
        </div>
      </div>
    </div>
    <div class="chart-box">
      <div class="chart-title">新系统</div>
      <div class="chart-area">
        <div class="screenshot-container">
          <img src="screenshots/new-system.png" alt="新系统" class="screenshot-img">
        </div>
      </div>
    </div>
  </div>
  <div class="foot">
    <div>新系统响应速度提升 40%</div>
    <div>2026-05</div>
  </div>
</section>
```

### 截图文件夹结构

```
项目/XXX/deck/
├── index.html
├── images/
│   ├── screenshots/
│   │   ├── chart-01.png
│   │   ├── dashboard-01.png
│   │   └── comparison-01.png
│   └── ...
└── ...
```
