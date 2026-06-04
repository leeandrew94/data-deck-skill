# 主题色预设（Themes）

4 套精心调配的视觉主题。**不允许用户自定义颜色——色彩搭配错了画面瞬间变丑**，只从以下预设中挑选。

---

## 使用方法

1. 选定风格后，找到对应的 `:root` 块
2. **整体替换**模板 `template.html` 中 `:root{...}` 里的所有变量
3. 其他 CSS 都走 `var(--...)`，无需任何其他改动

---

## 1. 📊 商务简洁（Business Clean）

**适合**：正式报告、管理层汇报、周报/月报、白色背景偏好
**调性**：白底 + 企业蓝，专业、可信、克制

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#f8fafc;
  --bg-card:#ffffff;
  --text-primary:#0f172a;
  --text-secondary:#475569;
  --text-muted:#94a3b8;
  --accent:#2563eb;
  --accent-2:#7c3aed;
  --accent-3:#059669;
  --accent-4:#d97706;
  --accent-light:rgba(37,99,235,.08);
  --border:#e2e8f0;
  --border-light:#cbd5e1;
  --shadow:0 1px 3px rgba(0,0,0,.08),0 1px 2px rgba(0,0,0,.04);
  --card-shadow:0 1px 3px rgba(0,0,0,.08),0 1px 2px rgba(0,0,0,.04);
  --radius:8px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(7vw,64px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  tooltip:{backgroundColor:'#fff',borderColor:'#e2e8f0',textStyle:{color:'#0f172a'},
           extraCssText:'box-shadow:0 4px 12px rgba(0,0,0,.1);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#e2e8f0'}},axisLabel:{color:'#94a3b8'}},
  valueAxis:{splitLine:{lineStyle:{color:'#e2e8f0'}}}
}
```

---

## 2. 🔬 数据科技（Data Tech）

**适合**：数据分析、产品看板、技术汇报、科技感
**调性**：深蓝底 + 青色高亮，冷静、理性、数据驱动

```css
:root{
  --bg-primary:#0f172a;
  --bg-secondary:#1e293b;
  --bg-card:#1e293b;
  --text-primary:#f1f5f9;
  --text-secondary:#94a3b8;
  --text-muted:#64748b;
  --accent:#38bdf8;
  --accent-2:#818cf8;
  --accent-3:#34d399;
  --accent-4:#fb923c;
  --accent-light:rgba(56,189,248,.12);
  --border:#334155;
  --border-light:#475569;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:6px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(8vw,72px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**（已在 template 中注册为 `data-deck` 主题）：
```javascript
{
  tooltip:{backgroundColor:'#1e293b',borderColor:'#334155',textStyle:{color:'#f1f5f9'}},
  categoryAxis:{axisLine:{lineStyle:{color:'#334155'}},axisLabel:{color:'#64748b'}},
  valueAxis:{splitLine:{lineStyle:{color:'#334155',opacity:.3}}}
}
```

---

## 3. 📄 极简白（Minimal White）

**适合**：打印/邮件、简洁清爽、低视觉噪声、正式文档
**调性**：纯白底 + 近黑文字，极致克制，内容为王

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#ffffff;
  --bg-card:#ffffff;
  --text-primary:#111827;
  --text-secondary:#6b7280;
  --text-muted:#9ca3af;
  --accent:#111827;
  --accent-2:#374151;
  --accent-3:#6b7280;
  --accent-4:#9ca3af;
  --accent-light:rgba(17,24,39,.05);
  --border:#e5e7eb;
  --border-light:#d1d5db;
  --shadow:none;
  --card-shadow:none;
  --radius:2px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(8vw,72px);
  --slide-padding:8vh 8vw;
  --gap:20px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#111827','#374151','#6b7280','#9ca3af','#d1d5db','#e5e7eb'],
  tooltip:{backgroundColor:'#fff',borderColor:'#e5e7eb',textStyle:{color:'#111827'},
           extraCssText:'box-shadow:0 2px 8px rgba(0,0,0,.06);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#e5e7eb'}},axisLabel:{color:'#9ca3af'}},
  valueAxis:{splitLine:{lineStyle:{color:'#e5e7eb'}}}
}
```

---

## 4. 🌃 暗黑科技（Dark Neon）

**适合**：炫酷展示、游戏/娱乐数据、发布会、社媒
**调性**：近黑底 + 霓虹紫，高冲击力、视觉系

```css
:root{
  --bg-primary:#0a0a0f;
  --bg-secondary:#12121a;
  --bg-card:#18181b;
  --text-primary:#e4e4e7;
  --text-secondary:#a1a1aa;
  --text-muted:#71717a;
  --accent:#a855f7;
  --accent-2:#06b6d4;
  --accent-3:#22c55e;
  --accent-4:#f472b6;
  --accent-light:rgba(168,85,247,.15);
  --border:#27272a;
  --border-light:#3f3f46;
  --shadow:none;
  --card-shadow:0 0 20px rgba(168,85,247,.08),0 0 0 1px rgba(168,85,247,.12);
  --radius:12px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(9vw,80px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#a855f7','#06b6d4','#22c55e','#f472b6','#fbbf24','#818cf8'],
  tooltip:{backgroundColor:'#18181b',borderColor:'#27272a',textStyle:{color:'#e4e4e7'},
           extraCssText:'box-shadow:0 0 20px rgba(168,85,247,.15);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#27272a'}},axisLabel:{color:'#71717a'}},
  valueAxis:{splitLine:{lineStyle:{color:'#27272a',opacity:.5}}}
}
```

---

## 5. 🔥 暖色商业（Warm Business）

**适合**：营销报告、销售复盘、消费数据、暖色偏好
**调性**：暖白底 + 琥珀橙，亲和、活力、商业感

```css
:root{
  --bg-primary:#fffbf5;
  --bg-secondary:#fef7ed;
  --bg-card:#ffffff;
  --text-primary:#1c1917;
  --text-secondary:#57534e;
  --text-muted:#a8a29e;
  --accent:#ea580c;
  --accent-2:#d97706;
  --accent-3:#16a34a;
  --accent-4:#dc2626;
  --accent-light:rgba(234,88,12,.08);
  --border:#e7e5e4;
  --border-light:#d6d3d1;
  --shadow:0 1px 3px rgba(0,0,0,.06),0 1px 2px rgba(0,0,0,.04);
  --card-shadow:0 1px 3px rgba(0,0,0,.06),0 1px 2px rgba(0,0,0,.04);
  --radius:10px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(7vw,64px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#ea580c','#d97706','#16a34a','#dc2626','#7c3aed','#0284c7'],
  tooltip:{backgroundColor:'#fff',borderColor:'#e7e5e4',textStyle:{color:'#1c1917'},
           extraCssText:'box-shadow:0 4px 12px rgba(0,0,0,.08);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#e7e5e4'}},axisLabel:{color:'#a8a29e'}},
  valueAxis:{splitLine:{lineStyle:{color:'#e7e5e4'}}}
}
```

---

## 6. 🎨 莫兰迪（Morandi）

**适合**：时尚/生活方式、创意行业、品牌报告、高级感
**调性**：灰调暖白 + 低饱和莫兰迪色系，柔和、高级、艺术感

```css
:root{
  --bg-primary:#f5f0eb;
  --bg-secondary:#efe8e0;
  --bg-card:#faf7f3;
  --text-primary:#3d3630;
  --text-secondary:#7a7067;
  --text-muted:#b5a99a;
  --accent:#b87e6e;
  --accent-2:#8b9e7e;
  --accent-3:#6e8b9e;
  --accent-4:#c4a882;
  --accent-light:rgba(184,126,110,.1);
  --border:#ddd5cb;
  --border-light:#ccc3b8;
  --shadow:0 2px 8px rgba(60,50,40,.06);
  --card-shadow:0 2px 8px rgba(60,50,40,.06);
  --radius:8px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(7vw,64px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#b87e6e','#8b9e7e','#6e8b9e','#c4a882','#9e7e8b','#7e8b6e'],
  tooltip:{backgroundColor:'#faf7f3',borderColor:'#ddd5cb',textStyle:{color:'#3d3630'},
           extraCssText:'box-shadow:0 2px 8px rgba(60,50,40,.1);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#ddd5cb'}},axisLabel:{color:'#b5a99a'}},
  valueAxis:{splitLine:{lineStyle:{color:'#ddd5cb',opacity:.6}}}
}
```

---

## 7. 🌊 深海蓝调（Deep Ocean）

**适合**：金融报告、企业年报、正式汇报、深色偏好
**调性**：深海蓝底 + 冰蓝高亮，沉稳、专业、信赖感

```css
:root{
  --bg-primary:#0c1929;
  --bg-secondary:#132238;
  --bg-card:#162640;
  --text-primary:#e2e8f0;
  --text-secondary:#8899ac;
  --text-muted:#5a6d82;
  --accent:#38a3d4;
  --accent-2:#5b8def;
  --accent-3:#34d399;
  --accent-4:#f59e0b;
  --accent-light:rgba(56,163,212,.12);
  --border:#1e3a55;
  --border-light:#2a4a68;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:6px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(8vw,72px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#38a3d4','#5b8def','#34d399','#f59e0b','#e879f9','#fb7185'],
  tooltip:{backgroundColor:'#162640',borderColor:'#1e3a55',textStyle:{color:'#e2e8f0'}},
  categoryAxis:{axisLine:{lineStyle:{color:'#1e3a55'}},axisLabel:{color:'#5a6d82'}},
  valueAxis:{splitLine:{lineStyle:{color:'#1e3a55',opacity:.4}}}
}
```

---

## 8. 🌿 清新绿意（Fresh Green）

**适合**：ESG 报告、健康医疗、环保数据、增长指标
**调性**：浅绿白底 + 森林绿，清新、自然、生机感

```css
:root{
  --bg-primary:#f7faf7;
  --bg-secondary:#eef5ee;
  --bg-card:#ffffff;
  --text-primary:#1a2e1a;
  --text-secondary:#4a6a4a;
  --text-muted:#8aaa8a;
  --accent:#16a34a;
  --accent-2:#0d9488;
  --accent-3:#ca8a04;
  --accent-4:#dc2626;
  --accent-light:rgba(22,163,74,.08);
  --border:#d4e8d4;
  --border-light:#bbddbb;
  --shadow:0 1px 3px rgba(0,60,0,.04);
  --card-shadow:0 1px 3px rgba(0,60,0,.04);
  --radius:10px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'JetBrains Mono','SF Mono',monospace;
  --kpi-font-size:min(7vw,64px);
  --slide-padding:6vh 6vw;
  --gap:16px;
  --transition:transform .6s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#16a34a','#0d9488','#ca8a04','#dc2626','#7c3aed','#0284c7'],
  tooltip:{backgroundColor:'#fff',borderColor:'#d4e8d4',textStyle:{color:'#1a2e1a'},
           extraCssText:'box-shadow:0 4px 12px rgba(0,60,0,.08);'},
  categoryAxis:{axisLine:{lineStyle:{color:'#d4e8d4'}},axisLabel:{color:'#8aaa8a'}},
  valueAxis:{splitLine:{lineStyle:{color:'#d4e8d4'}}}
}
```

---

## 9. 💼 商务汇报（Business Report）

**适合**：正式商务汇报、管理层演示、年度总结、战略规划
**调性**：白底 + 克莱因蓝，极简、专业、瑞士国际主义风格

> 注意：此风格使用 `template-business.html` 模板，采用无衬线字体、直角纯色、极致字号对比。

### 克莱因蓝 IKB（默认）

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#f8fafc;
  --bg-card:#ffffff;
  --text-primary:#0f172a;
  --text-secondary:#475569;
  --text-muted:#94a3b8;
  --accent:#002FA7;
  --accent-light:rgba(0,47,167,.08);
  --border:#e2e8f0;
  --border-light:#cbd5e1;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:0px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'SF Mono',monospace;
  --kpi-font-size:min(10vw,96px);
  --slide-padding:6vh 6vw;
  --gap:24px;
  --transition:transform .4s cubic-bezier(.4,0,.2,1);
}
```

### 柠檬黄

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#f8fafc;
  --bg-card:#ffffff;
  --text-primary:#0f172a;
  --text-secondary:#475569;
  --text-muted:#94a3b8;
  --accent:#FFD500;
  --accent-light:rgba(255,213,0,.08);
  --border:#e2e8f0;
  --border-light:#cbd5e1;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:0px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'SF Mono',monospace;
  --kpi-font-size:min(10vw,96px);
  --slide-padding:6vh 6vw;
  --gap:24px;
  --transition:transform .4s cubic-bezier(.4,0,.2,1);
}
```

### 柠檬绿

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#f8fafc;
  --bg-card:#ffffff;
  --text-primary:#0f172a;
  --text-secondary:#475569;
  --text-muted:#94a3b8;
  --accent:#C5E803;
  --accent-light:rgba(197,232,3,.08);
  --border:#e2e8f0;
  --border-light:#cbd5e1;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:0px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'SF Mono',monospace;
  --kpi-font-size:min(10vw,96px);
  --slide-padding:6vh 6vw;
  --gap:24px;
  --transition:transform .4s cubic-bezier(.4,0,.2,1);
}
```

### 安全橙

```css
:root{
  --bg-primary:#ffffff;
  --bg-secondary:#f8fafc;
  --bg-card:#ffffff;
  --text-primary:#0f172a;
  --text-secondary:#475569;
  --text-muted:#94a3b8;
  --accent:#FF6B35;
  --accent-light:rgba(255,107,53,.08);
  --border:#e2e8f0;
  --border-light:#cbd5e1;
  --shadow:none;
  --card-shadow:0 0 0 1px var(--border);
  --radius:0px;
  --font-sans:'Inter','Noto Sans SC',-apple-system,sans-serif;
  --font-mono:'SF Mono',monospace;
  --kpi-font-size:min(10vw,96px);
  --slide-padding:6vh 6vw;
  --gap:24px;
  --transition:transform .4s cubic-bezier(.4,0,.2,1);
}
```

**ECharts 额外配置**：
```javascript
{
  color:['#002FA7','#475569','#94a3b8','#cbd5e1','#64748b','#334155','#1e293b','#0f172a'],
  tooltip:{backgroundColor:'#fff',borderColor:'#e2e8f0',textStyle:{color:'#0f172a'}},
  categoryAxis:{axisLine:{lineStyle:{color:'#e2e8f0'}},axisLabel:{color:'#94a3b8'}},
  valueAxis:{splitLine:{lineStyle:{color:'#e2e8f0',opacity:.3}}}
}
```
