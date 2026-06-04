# 图表类型选择规则

本文档定义：给定数据特征，应该选什么图表、怎么配 ECharts option。

---

## 选择决策树

```
输入: 数据列类型组合 + 行数 + 用户意图

→ 单数值列，无维度
  → KPI 大字报（不是图表，是大数字 + 涨跌箭头 + 对比说明）

→ 1 分类 + 1 数值
  → ≤8 类 → 柱状图（vertical bar）
  → >8 类 → 水平条形图（horizontal bar），按数值排序
  → ≤6 类 且用户要"占比" → 饼图 / 环形图

→ 1 时间 + 1 数值
  → 连续时间 → 折线图
  → 累计/占比 → 面积图（area）
  → 时间点 < 8 → 柱状图也行

→ 1 时间 + 2+ 数值
  → 多折线图（legend 可切换）
  → 如果数值是"部分与整体" → 堆叠面积图

→ 1 时间 + 1 分类 + 1 数值
  → 堆叠柱状图（stacked bar）
  → 多折线图（每条线一个分类）

→ 2 数值（散点）
  → 散点图
  → 有第 3 个数值 → 气泡图（size 映射）

→ 排名/Top N
  → 水平条形图，按数值降序，取 Top 10

→ 分布
  → 直方图（histogram）
  → 箱线图（boxplot）

→ 多维对比（≤8 维）
  → 雷达图（radar）

→ 占比/组成
  → 饼图（≤6 类）
  → 环形图（donut）
  → 玫瑰图（rose type: 'area'）

→ 漏斗/转化
  → 漏斗图（funnel）
```

---

## ECharts 配置模板

### 柱状图（Bar）

```javascript
{
  tooltip:{trigger:'axis'},
  xAxis:{type:'category',data:/*分类数组*/},
  yAxis:{type:'value',name:'/*指标名*/'},
  series:[{
    type:'bar',
    data:/*数值数组*/,
    itemStyle:{borderRadius:[4,4,0,0]},
    label:{show:false,position:'top',fontSize:11}
  }],
  grid:{left:60,right:24,top:48,bottom:36}
}
```

### 水平条形图（Horizontal Bar）

```javascript
{
  tooltip:{trigger:'axis'},
  xAxis:{type:'value'},
  yAxis:{type:'category',data:/*分类数组*/,inverse:true},
  series:[{
    type:'bar',
    data:/*数值数组*/,
    itemStyle:{borderRadius:[0,4,4,0]},
    label:{show:true,position:'right',fontSize:11,formatter:'{c}'}
  }],
  grid:{left:100,right:60,top:24,bottom:24}
}
```

### 折线图（Line）

```javascript
{
  tooltip:{trigger:'axis'},
  xAxis:{type:'category',data:/*时间数组*/},
  yAxis:{type:'value'},
  series:[{
    type:'line',
    data:/*数值数组*/,
    smooth:true,
    symbol:'circle',
    symbolSize:6,
    lineStyle:{width:2},
    areaStyle:{opacity:0.08}
  }],
  grid:{left:60,right:24,top:48,bottom:36}
}
```

### 多折线图（Multi-Line）

```javascript
{
  tooltip:{trigger:'axis'},
  legend:{top:0,right:0},
  xAxis:{type:'category',data:/*时间数组*/},
  yAxis:{type:'value'},
  series:[
    {name:'系列A',type:'line',data:/*...*/,smooth:true},
    {name:'系列B',type:'line',data:/*...*/,smooth:true}
  ],
  grid:{left:60,right:24,top:48,bottom:36}
}
```

### 饼图（Pie）

```javascript
{
  tooltip:{trigger:'item',formatter:'{b}: {c} ({d}%)'},
  legend:{bottom:0,type:'scroll'},
  series:[{
    type:'pie',
    radius:['40%','70%'],
    data:[/*{name,value}数组*/],
    label:{formatter:'{b}\n{d}%',fontSize:12},
    emphasis:{itemStyle:{shadowBlur:10,shadowColor:'rgba(0,0,0,.3)'}}
  }]
}
```

### 散点图（Scatter）

```javascript
{
  tooltip:{trigger:'item',formatter:function(p){return p.data[0]+', '+p.data[1]}},
  xAxis:{type:'value',name:'/*X轴标签*/'},
  yAxis:{type:'value',name:'/*Y轴标签*/'},
  series:[{
    type:'scatter',
    data:/*[[x,y],...]数组*/,
    symbolSize:10,
    itemStyle:{opacity:0.7}
  }],
  grid:{left:60,right:24,top:48,bottom:48}
}
```

### 雷达图（Radar）

```javascript
{
  tooltip:{},
  radar:{indicator:[/*{name,max}数组*/]},
  series:[{
    type:'radar',
    data:[{value:/*数值数组*/,name:'/*系列名*/'}],
    areaStyle:{opacity:0.15}
  }]
}
```

### 漏斗图（Funnel）

```javascript
{
  tooltip:{trigger:'item',formatter:'{b}: {c}'},
  series:[{
    type:'funnel',
    left:'10%',right:'10%',top:40,bottom:20,
    min:0,max:100,
    sort:'descending',
    gap:4,
    data:[/*{name,value}数组*/],
    label:{show:true,position:'inside',fontSize:13}
  }]
}
```

### 堆叠柱状图（Stacked Bar）

```javascript
{
  tooltip:{trigger:'axis'},
  legend:{top:0,right:0},
  xAxis:{type:'category',data:/*分类数组*/},
  yAxis:{type:'value'},
  series:[
    {name:'系列A',type:'bar',stack:'total',data:/*...*/},
    {name:'系列B',type:'bar',stack:'total',data:/*...*/}
  ],
  grid:{left:60,right:24,top:48,bottom:36}
}
```

---

## 反模式（绝对不能做）

1. **饼图 > 8 个分类** → 改用水平条形图
2. **折线图用于非连续 X 轴**（如"苹果/香蕉/橘子"）→ 改用柱状图
3. **数值轴不从 0 开始**（除非用户明确要求，如股票 K 线）
4. **一个页面堆超过 3 张图表** → 拆成多页
5. **图表没有标题** — 必须有 `title.text`
6. **图表没有 tooltip** — 必须配置 `tooltip`
7. **数字不格式化** — 金额加 ¥，百分比加 %，大数用万/亿
8. **颜色不统一** — 同一份 deck 所有图表用同一套配色（从主题取）
