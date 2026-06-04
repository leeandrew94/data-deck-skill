# 数据分析流水线

本文档定义：如何从原始 CSV/Excel 数据中提取结构化信息，驱动图表选择和内容生成。

---

## 1. CSV 解析

### 编码检测
优先尝试 UTF-8，失败后尝试 GBK/GB2312。

### 分隔符检测
按优先级尝试：逗号 → 制表符 → 分号。取第一行分割后列数最多的。

### 空值识别
以下值视为 null：`""`, `"NA"`, `"N/A"`, `"null"`, `"-"`, `"--"`, `"无"`, `"暂无"`

---

## 2. 列类型检测

对每列采样前 100 个非空值，按优先级判断：

### TEMPORAL（时间列）
- 可被 `new Date()` 解析且不为 NaN
- 表头包含：date, time, 日期, 时间, 年, 月, 日, timestamp, created, updated
- 值匹配模式：YYYY-MM-DD, YYYY/MM/DD, DD/MM/YYYY, YYYYMMDD

### NUMERIC（数值列）
- >80% 的采样值可被 `parseFloat()` 解析
- 表头包含：amount, count, total, sum, avg, price, qty, 金额, 数量, 总计, 价格, 均价, 总额
- 子类型判断：
  - **CURRENCY**：表头含 $, price, amount, 金额, 价格, 收入, 支出, 成本
  - **PERCENTAGE**：表头含 %, rate, ratio, 率, 比, 占比，且值在 [0,1] 或 [0,100]
  - **DISCRETE**：全部为整数且唯一值 < 30

### CATEGORICAL（分类列）
- 唯一值 < min(20, 5% 总行数)
- 布尔值（true/false, yes/no, 是/否, 0/1）

### TEXT（文本列）
- 以上都不满足的自由文本

---

## 3. 统计分析

### 数值列统计
```python
min_val    = min(非空值)
max_val    = max(非空值)
mean_val   = mean(非空值)
median_val = median(非空值)
std_val    = std(非空值)
q25        = percentile(25)
q75        = percentile(75)
q95        = percentile(95)
null_count = 空值数量
outliers   = 值 < q25-1.5*IQR 或 > q75+1.5*IQR
```

### 分类列统计
```python
unique_count = 唯一值数量
top_values   = 频率最高的 10 个值及其计数
null_count   = 空值数量
```

### 时间列统计
```python
min_date   = 最早日期
max_date   = 最晚日期
range_days = 日期跨度（天）
granularity = 推断粒度（hourly/daily/weekly/monthly/yearly）
gaps       = 时间序列中的断裂点
```

---

## 4. 关键指标推断

根据列类型组合，自动推断 KPI：

| 数据特征 | 推荐 KPI |
|---------|---------|
| 有金额列 | 总金额、平均金额、最大单笔 |
| 有数量列 | 总数量、日均数量 |
| 有时间列 | 时间跨度、最新日期 |
| 有分类列 | 分类数量、Top 1 分类 |
| 有百分比列 | 平均率、最高率、最低率 |
| 两列数值可计算 | 环比变化率、同比增长率 |

---

## 5. 数据转换

### 聚合规则
- 分类 > 20 个 → 取 Top 10 + "其他"
- 时间粒度过细（秒级）→ 聚合到分钟/小时/天
- 数值列过多 → 选信息量最大的 3-5 个

### 排序规则
- 分类图表默认按数值降序
- 时间图表默认按时间升序
- 排名图表必须降序

### 格式化规则
- 金额：保留 2 位小数，加货币符号
- 百分比：乘 100，保留 1 位小数，加 %
- 大数：> 10000 用万，> 100000000 用亿
- 日期：YYYY-MM-DD（日级），YYYY-MM（月级），YYYY（年级）
