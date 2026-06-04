# 页面布局模板

本文档收录数据演示文稿的常用页面布局。每种都是一个完整的 `<section class="slide">` 代码块。

---

## 0. 基础结构

所有 slide 共用：

```html
<section class="slide">
  <div class="chrome">
    <div>分类标签 · 子标签</div>
    <div>页码 / 总页数</div>
  </div>
  <!-- 主内容区域 -->
  <div class="foot">
    <div>说明文字</div>
    <div>数据来源 · 日期</div>
  </div>
</section>
```

---

## 1. 封面

```html
<section class="slide cover">
  <div class="title" data-anim>演示标题</div>
  <div class="subtitle" data-anim>副标题或一句话概述</div>
  <div class="meta" data-anim>数据来源 · 日期</div>
</section>
```

---

## 2. KPI 大字报

展示 3-5 个关键指标。最适合放在封面之后、图表之前。

```html
<section class="slide">
  <div class="chrome">
    <div>关键指标</div>
    <div>02 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>核心指标概览</div>
  <div class="slide-subtitle" data-anim>数据截至 YYYY-MM-DD</div>
  <div class="kpi-row">
    <div class="kpi-card" data-anim>
      <div class="label">指标名称</div>
      <div class="value">1,234</div>
      <div class="change up">+12.3% 环比</div>
      <div class="note">对比说明</div>
    </div>
    <!-- 更多 KPI 卡片... -->
  </div>
  <div class="foot">
    <div>说明</div>
    <div>日期</div>
  </div>
</section>
```

**KPI 选择原则**：
- 选 3-5 个最关键的指标，不要堆太多
- 每个 KPI 必须有：当前值 + 变化趋势（环比/同比）+ 简短说明
- 数值格式化：金额用 `fmt.currency()`，大数用 `fmt.cn()`，百分比用 `fmt.pct()`
- 涨跌颜色：涨用 `.up`（绿），跌用 `.down`（红），持平用 `.neutral`（灰）

---

## 3. 单图表页

一页一张图表，最常用的布局。

```html
<section class="slide">
  <div class="chrome">
    <div>图表分类</div>
    <div>03 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>图表标题</div>
  <div class="slide-subtitle" data-anim>图表说明或关键结论</div>
  <div class="chart-row cols-1" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-area" id="chart-1"></div>
    </div>
  </div>
  <div class="foot">
    <div>数据说明</div>
    <div>日期</div>
  </div>
</section>
```

---

## 4. 双图表对比页

两张图表并排，适合对比分析。

```html
<section class="slide">
  <div class="chrome">
    <div>对比分析</div>
    <div>04 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>对比标题</div>
  <div class="chart-row cols-2" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-title">左图标题</div>
      <div class="chart-subtitle">左图说明</div>
      <div class="chart-area" id="chart-2a"></div>
    </div>
    <div class="chart-box">
      <div class="chart-title">右图标题</div>
      <div class="chart-subtitle">右图说明</div>
      <div class="chart-area" id="chart-2b"></div>
    </div>
  </div>
  <div class="foot">
    <div>说明</div>
    <div>日期</div>
  </div>
</section>
```

**比例变体**：
- `cols-2` — 等分
- `ratio-6-4` — 六四分（主图更大）
- `ratio-7-3` — 七三分（强调主图）

---

## 5. 图表 + KPI 混合页

左侧/上方放 KPI，右侧/下方放图表。

```html
<section class="slide">
  <div class="chrome">
    <div>主题</div>
    <div>05 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>标题</div>
  <div class="kpi-row" style="margin-bottom:2vh">
    <div class="kpi-card" data-anim>
      <div class="label">指标</div>
      <div class="value">456</div>
      <div class="change up">+8%</div>
    </div>
    <div class="kpi-card" data-anim>
      <div class="label">指标</div>
      <div class="value">789</div>
      <div class="change down">-3%</div>
    </div>
  </div>
  <div class="chart-row cols-1" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-area" id="chart-3"></div>
    </div>
  </div>
  <div class="foot">
    <div>说明</div>
    <div>日期</div>
  </div>
</section>
```

---

## 6. 数据洞察页

以文字为主，展示从数据中提炼的关键结论。

```html
<section class="slide insight-slide">
  <div class="section-label" data-anim>数据洞察</div>
  <h2 data-anim>一句话总结核心发现</h2>
  <ul class="insight-list">
    <li data-anim>洞察 1：具体发现，包含关键数字</li>
    <li data-anim>洞察 2：趋势或异常，有数据支撑</li>
    <li data-anim>洞察 3：建议或下一步行动</li>
  </ul>
</section>
```

**洞察写作原则**：
- 每条洞察必须有数据支撑（"销售额增长 12%"，不是"销售额有所增长"）
- 先说结论，再说原因
- 用对比增强说服力（"环比"、"同比"、"vs 目标"）
- 最后一条可以是建议/行动项

---

## 7. 数据表格页

展示原始数据预览。仅在行数 < 100 时使用。

```html
<section class="slide">
  <div class="chrome">
    <div>数据明细</div>
    <div>07 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>数据预览</div>
  <div class="data-table-wrap">
    <table class="data-table">
      <thead>
        <tr>
          <th>列1</th>
          <th>列2</th>
          <th class="num">数值列</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>数据</td>
          <td>数据</td>
          <td class="num">1,234</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="foot">
    <div>共 N 行数据</div>
    <div>日期</div>
  </div>
</section>
```

---

## 8. 结束页

```html
<section class="slide closing">
  <div class="end-title" data-anim>总结标题</div>
  <div class="end-sub" data-anim>下一步建议或行动项</div>
  <div class="meta" style="margin-top:6vh;font-family:var(--font-mono);font-size:13px;color:var(--text-muted)" data-anim>
    数据来源 · 报告日期
  </div>
</section>
```

---

## 页面节奏规划

**硬规则**：
- 封面 → KPI 大字报 → 图表页（2-5 页）→ 洞察页 → 结束页
- 总页数 = 5-10 页（15 分钟汇报），10-15 页（30 分钟）
- 不要连续 3 页以上都是同类型（如连续 5 页图表）
- 每 3-4 页图表插入 1 页洞察/总结
- KPI 大字报必须在图表之前——先给全局印象，再展开细节
- 结束页必须有总结或下一步建议

---

## 9. 时间线页面

展示事件、里程碑或流程的时间顺序。

```html
<section class="slide">
  <div class="chrome">
    <div>发展历程</div>
    <div>09 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>项目时间线</div>
  <div class="slide-subtitle" data-anim>关键里程碑回顾</div>
  <div class="timeline" style="flex:1;min-height:0;overflow-y:auto">
    <div class="timeline-item" data-anim>
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="timeline-title">项目启动</div>
        <div class="timeline-desc">完成需求分析和团队组建</div>
        <div class="timeline-date">2026-01</div>
      </div>
    </div>
    <div class="timeline-item" data-anim>
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="timeline-title">开发完成</div>
        <div class="timeline-desc">核心功能开发完毕，进入测试阶段</div>
        <div class="timeline-date">2026-03</div>
      </div>
    </div>
    <div class="timeline-item" data-anim>
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="timeline-title">正式上线</div>
        <div class="timeline-desc">系统部署上线，开始运营</div>
        <div class="timeline-date">2026-05</div>
      </div>
    </div>
  </div>
  <div class="foot">
    <div>项目周期：5个月</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 10. 对比页面（Before/After）

展示改进前后的对比效果。

```html
<section class="slide">
  <div class="chrome">
    <div>对比分析</div>
    <div>10 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>系统优化对比</div>
  <div class="slide-subtitle" data-anim>优化前后性能指标对比</div>
  <div class="chart-row cols-2" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-title">优化前</div>
      <div class="chart-subtitle">2026-01 数据</div>
      <div class="chart-area" id="chart-before"></div>
    </div>
    <div class="chart-box">
      <div class="chart-title">优化后</div>
      <div class="chart-subtitle">2026-05 数据</div>
      <div class="chart-area" id="chart-after"></div>
    </div>
  </div>
  <div class="foot">
    <div>响应时间减少 40%，吞吐量提升 60%</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 11. 流程图页面

展示业务流程或工作流程。

```html
<section class="slide">
  <div class="chrome">
    <div>业务流程</div>
    <div>11 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>数据处理流程</div>
  <div class="slide-subtitle" data-anim>从数据采集到报告生成</div>
  <div style="flex:1;min-height:0;display:flex;align-items:center;justify-content:center">
    <div style="display:flex;gap:24px;align-items:center">
      <div class="kpi-card" data-anim style="min-width:150px;text-align:center">
        <div class="label">数据采集</div>
        <div class="value" style="font-size:24px">1</div>
      </div>
      <div style="font-size:24px;color:var(--text-muted)">→</div>
      <div class="kpi-card" data-anim style="min-width:150px;text-align:center">
        <div class="label">数据清洗</div>
        <div class="value" style="font-size:24px">2</div>
      </div>
      <div style="font-size:24px;color:var(--text-muted)">→</div>
      <div class="kpi-card" data-anim style="min-width:150px;text-align:center">
        <div class="label">数据分析</div>
        <div class="value" style="font-size:24px">3</div>
      </div>
      <div style="font-size:24px;color:var(--text-muted)">→</div>
      <div class="kpi-card" data-anim style="min-width:150px;text-align:center">
        <div class="label">报告生成</div>
        <div class="value" style="font-size:24px">4</div>
      </div>
    </div>
  </div>
  <div class="foot">
    <div>全流程自动化，耗时 < 5 分钟</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 12. 多图表网格页面

同时展示多个相关图表。

```html
<section class="slide">
  <div class="chrome">
    <div>多维分析</div>
    <div>12 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>销售多维分析</div>
  <div class="slide-subtitle" data-anim>从不同维度洞察销售数据</div>
  <div class="chart-row cols-3" style="flex:1;min-height:0">
    <div class="chart-box">
      <div class="chart-title">按地区</div>
      <div class="chart-area" id="chart-region"></div>
    </div>
    <div class="chart-box">
      <div class="chart-title">按品类</div>
      <div class="chart-area" id="chart-category"></div>
    </div>
    <div class="chart-box">
      <div class="chart-title">按时间</div>
      <div class="chart-area" id="chart-time"></div>
    </div>
  </div>
  <div class="foot">
    <div>华东区贡献最大，数码品类增长最快</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 13. 大数据展示页

突出展示单个关键数据。

```html
<section class="slide">
  <div class="chrome">
    <div>关键数据</div>
    <div>13 / 总页数</div>
  </div>
  <div style="flex:1;min-height:0;display:flex;flex-direction:column;justify-content:center;align-items:center;text-align:center">
    <div data-anim style="font-size:min(18vw,160px);font-weight:700;color:var(--accent);line-height:1">¥1,234万</div>
    <div data-anim style="font-size:min(2vw,24px);color:var(--text-secondary);margin-top:2vh">2026年Q1总销售额</div>
    <div data-anim style="font-size:min(1.2vw,16px);color:var(--accent-3);margin-top:1vh">↑ 12.3% vs 上季度</div>
  </div>
  <div class="foot">
    <div>数据来源：财务系统</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 14. 引用页面

展示重要观点或结论。

```html
<section class="slide">
  <div class="chrome">
    <div>核心观点</div>
    <div>14 / 总页数</div>
  </div>
  <div style="flex:1;min-height:0;display:flex;flex-direction:column;justify-content:center;align-items:flex-start;max-width:80vw;margin:0 auto">
    <div data-anim style="font-size:min(4vw,48px);font-weight:300;line-height:1.3;color:var(--text-primary);margin-bottom:3vh">
      "数据驱动决策不是选择，而是必须。"
    </div>
    <div data-anim style="font-size:min(1.4vw,18px);color:var(--text-secondary)">
      — 张三，首席数据官
    </div>
  </div>
  <div class="foot">
    <div>2026 数据战略峰会</div>
    <div>2026-05</div>
  </div>
</section>
```

---

## 15. 团队/组织架构页

展示团队结构或组织架构。

```html
<section class="slide">
  <div class="chrome">
    <div>团队架构</div>
    <div>15 / 总页数</div>
  </div>
  <div class="slide-title" data-anim>数据团队架构</div>
  <div class="slide-subtitle" data-anim>核心团队成员</div>
  <div style="flex:1;min-height:0;display:flex;flex-direction:column;justify-content:center;align-items:center">
    <div class="kpi-card" data-anim style="min-width:300px;text-align:center;margin-bottom:2vh">
      <div class="label">团队负责人</div>
      <div class="value" style="font-size:24px">张三</div>
      <div class="note">首席数据官</div>
    </div>
    <div style="display:flex;gap:24px">
      <div class="kpi-card" data-anim style="min-width:180px;text-align:center">
        <div class="label">数据分析</div>
        <div class="value" style="font-size:20px">5 人</div>
      </div>
      <div class="kpi-card" data-anim style="min-width:180px;text-align:center">
        <div class="label">数据工程</div>
        <div class="value" style="font-size:20px">3 人</div>
      </div>
      <div class="kpi-card" data-anim style="min-width:180px;text-align:center">
        <div class="label">产品运营</div>
        <div class="value" style="font-size:20px">2 人</div>
      </div>
    </div>
  </div>
  <div class="foot">
    <div>数据团队共 10 人</div>
    <div>2026-05</div>
  </div>
</section>
```
