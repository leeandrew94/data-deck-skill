#!/usr/bin/env node
import { readFileSync } from 'node:fs';

const file = process.argv[2];
if (!file) {
  console.error('Usage: node scripts/validate-deck.mjs <index.html>');
  process.exit(2);
}

const html = readFileSync(file, 'utf8');
const errors = [];
const warnings = [];

// ========== 结构检查 ==========

// 1. title 占位符
if (/\[必填\]/.test(html)) {
  errors.push('P0: <title> 仍包含 [必填] 占位符');
}

// 2. deck slides 占位符
if (/DECK_SLIDES_HERE/.test(html)) {
  errors.push('P0: 仍包含 DECK_SLIDES_HERE 占位符，slide 未填充');
}

// 3. 有 slide
const slideCount = (html.match(/<section[^>]*class="[^"]*\bslide\b[^"]*"/g) || []).length;
if (slideCount === 0) {
  errors.push('P0: 没有找到 <section class="slide"> 页面');
} else {
  console.log(`✓ 找到 ${slideCount} 页 slide`);
}

// 4. 有 ECharts
if (!/echarts/.test(html)) {
  errors.push('P0: 未找到 ECharts 相关代码');
} else {
  console.log('✓ ECharts 已集成');
}

// 5. 有图表容器
const chartIds = (html.match(/id="chart-[^"]*"/g) || []);
if (chartIds.length === 0) {
  warnings.push('P1: 未找到图表容器 (id="chart-*")');
} else {
  console.log(`✓ 找到 ${chartIds.length} 个图表容器`);
}

// 6. 有 KPI 卡片
const kpiCards = (html.match(/class="[^"]*\bkpi-card\b[^"]*"/g) || []);
if (kpiCards.length === 0) {
  warnings.push('P1: 未找到 KPI 卡片');
} else {
  console.log(`✓ 找到 ${kpiCards.length} 个 KPI 卡片`);
}

// ========== 数据检查 ==========

// 7. 有数据嵌入（可选）
const hasData = /id="deck-data"/.test(html);
if (hasData) {
  try {
    const dataMatch = html.match(/<script[^>]*id="deck-data"[^>]*>([\s\S]*?)<\/script>/);
    if (dataMatch) {
      const data = JSON.parse(dataMatch[1]);
      if (data.rows && data.rows.length > 0) {
        console.log(`✓ 嵌入数据: ${data.rows.length} 行, ${data.columns ? data.columns.length : '?'} 列`);
      }
    }
  } catch (e) {
    warnings.push('P2: deck-data JSON 解析失败: ' + e.message);
  }
}

// ========== 图表检查 ==========

// 8. 检查 ECharts setOption 调用
const setOptionCalls = (html.match(/setOption\s*\(/g) || []);
if (setOptionCalls.length > 0) {
  console.log(`✓ 找到 ${setOptionCalls.length} 个 setOption 调用`);

  // 检查饼图数据点数量
  const pieMatches = html.match(/type:\s*['"]pie['"]/g);
  if (pieMatches) {
    // 粗略检查：如果有 pie，检查 data 数组长度
    const dataArrays = html.match(/type:\s*['"]pie['"][\s\S]*?data:\s*\[([\s\S]*?)\]/g);
    if (dataArrays) {
      dataArrays.forEach((match, i) => {
        const items = (match.match(/\{[^}]*name:/g) || []).length;
        if (items > 8) {
          errors.push(`P0: 饼图 #${i + 1} 有 ${items} 个分类（不应超过 8 个）`);
        }
      });
    }
  }
} else {
  warnings.push('P1: 未找到 setOption 调用，图表可能未配置');
}

// ========== 主题检查 ==========

// 9. CSS 变量定义
if (!/:root/.test(html)) {
  warnings.push('P1: 未找到 :root CSS 变量定义');
}

// 10. 检查硬编码颜色（排除 CSS 变量和 ECharts 配色）
const inlineColors = html.match(/style="[^"]*color:\s*#[0-9a-fA-F]{3,8}/g);
if (inlineColors && inlineColors.length > 5) {
  warnings.push(`P2: 发现 ${inlineColors.length} 处 inline 硬编码颜色，建议使用 CSS 变量`);
}

// ========== 响应式检查 ==========

// 11. viewport meta
if (!/viewport/.test(html)) {
  errors.push('P0: 缺少 viewport meta 标签');
}

// ========== 交互检查 ==========

// 12. tooltip 配置
if (!/tooltip/.test(html)) {
  warnings.push('P1: 未找到 tooltip 配置');
} else {
  console.log('✓ tooltip 已配置');
}

// 13. 翻页
if (/ArrowRight|ArrowLeft/.test(html)) {
  console.log('✓ 键盘翻页已配置');
}

// 14. registerChart 调用
const registerCalls = (html.match(/registerChart\s*\(/g) || []).length;
if (registerCalls > 0) {
  console.log(`✓ ${registerCalls} 个图表已注册自适应`);
}

// ========== 导出检查 ==========

// 15. 打印样式
if (!/@media\s*print/.test(html)) {
  warnings.push('P2: 未找到 @media print 打印样式');
}

// ========== 导航检查 ==========

// 16. 导航点
if (!/id="nav"/.test(html)) {
  warnings.push('P2: 未找到导航点容器');
}

// ========== 输出结果 ==========

console.log('\n========== 检查结果 ==========');

if (errors.length > 0) {
  console.log(`\n❌ ${errors.length} 个错误 (P0):`);
  errors.forEach(e => console.log('  • ' + e));
}

if (warnings.length > 0) {
  console.log(`\n⚠️  ${warnings.length} 个警告:`);
  warnings.forEach(w => console.log('  • ' + w));
}

if (errors.length === 0 && warnings.length === 0) {
  console.log('\n✅ 全部通过！');
}

console.log(`\n总结: ${errors.length} 错误, ${warnings.length} 警告, ${slideCount} 页 slide, ${chartIds.length} 个图表`);

process.exit(errors.length > 0 ? 1 : 0);
