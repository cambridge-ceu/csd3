
# Claude Code 终极使用指南（截至 2026 年 5 月 23 日）

> 作者整理与增强版  
> 原文基础上进行了结构优化、格式重构、实战补充与企业级工作流增强。  
> 内容仅供参考，请以官方文档为准。

---

# 目录

1. Claude Code 是什么
2. 安装与初始化
3. Claude Code 生态工具链
4. 命令体系与常用命令
5. Skills 技能系统
6. CLAUDE.md 长期记忆系统
7. Prompt 工程与高效提示词
8. MCP 全面详解
9. 推荐 MCP 组合
10. 多 Agent 工作流
11. Context 管理策略
12. 企业级最佳实践
13. 常见误区
14. 推荐学习路径
15. 总结

---

# 一、Claude Code 是什么

Claude Code 是 Anthropic 推出的 AI 编程 Agent。

它已经不只是一个“代码生成工具”。

到了 2026 年，Claude Code 更像：

- AI 软件工程师
- AI DevOps 助手
- 自动化开发工作站
- 可操作真实项目的智能 Agent

Claude Code 能够：

- 理解整个代码库
- 修改多文件代码
- 自动执行终端命令
- 编写与运行测试
- 自动 Review PR
- 审计安全漏洞
- 管理 Git 工作流
- 调用数据库
- 联网搜索资料
- 调用浏览器
- 自动化复杂工作流

其真正核心并不是“写代码”。

而是：

# 自动化软件工程

---

# 二、安装与初始化

## 环境准备

安装前请确保：

- Claude.ai 账号
- 手机验证
- Git 环境
- Node.js 18+（仅 npm 安装需要）
- macOS / Linux / Windows / WSL

---

# 官方原生安装（推荐）

2026 年后，Anthropic 主推零依赖原生安装。

## macOS / Linux / WSL

```bash
# 稳定版
curl -fsSL https://claude.ai/install.sh | bash

# 最新版
curl -fsSL https://claude.ai/install.sh | bash -s latest

# 指定版本
curl -fsSL https://claude.ai/install.sh | bash -s 1.0.58
```

---

## Homebrew 安装

```bash
brew install --cask claude-code
```

---

## Windows PowerShell

```powershell
# 稳定版
irm https://claude.ai/install.ps1 | iex

# 最新版
& ((scriptblock)::Create((irm https://claude.ai/install.ps1))) latest
```

---

# npm 安装（传统方式）

```bash
npm install -g @anthropic-ai/claude-code
```

适合：

- CI/CD
- 固定版本环境
- Node 开发者

---

# 验证安装

```bash
claude --version
```

启动：

```bash
claude
```

首次启动后：

- 浏览器 OAuth 登录
- 自动缓存 Token
- 后续无需重复登录

---

# 三、Claude Code 生态工具链

真正高阶用户不会只使用 Claude Code 本体。

配套工具会极大提升效率。

---

## 推荐工具

| 工具 | 作用 |
|---|---|
| ccflare | 使用情况仪表板 |
| Claude Squad | 多实例管理 |
| ccusage | Token 与成本分析 |
| CCometixLine | 终端状态栏 |
| claude-sound-fx | 声音反馈 |
| claude-dev-toolkit | AI 工作流工具箱 |
| codesight | 降低上下文消耗 |
| cc-switch | 国内模型切换工具 |

---

## CCometixLine

显示：

- 当前模型
- Git 分支
- Context 占用
- 当前 Agent
- Token 使用率

安装：

```bash
npm install -g @cometix/ccline
```

---

# 四、命令体系与常用命令

Claude Code 命令分三类：

1. CLI Commands
2. Slash Commands
3. Keyboard Shortcuts

---

# CLI Commands

| 命令 | 说明 |
|---|---|
| claude | 启动交互模式 |
| claude "task" | 一次性任务 |
| claude -p | 查询后退出 |
| claude -c | 恢复最近会话 |
| claude commit | 自动生成 Git Commit |
| claude update | 更新版本 |
| claude mcp add | 添加 MCP |
| claude mcp list | 查看 MCP |

---

# Slash Commands

## 会话管理

| 命令 | 功能 |
|---|---|
| /clear | 清空上下文 |
| /compact | 压缩上下文 |
| /resume | 恢复会话 |
| /btw | 临时侧边提问 |

---

# /compact vs /clear

## /compact

适合：

- 同一任务继续
- 保留关键上下文
- 节省 Token

## /clear

适合：

- 全新任务
- 避免上下文污染

建议：

当 Context 使用率达到：

```text
70% ~ 80%
```

立刻执行：

```bash
/compact
```

---

# Context 管理命令

| 命令 | 功能 |
|---|---|
| /context | 查看上下文占用 |
| /cost | 查看成本 |
| /memory | 编辑 CLAUDE.md |

---

# 模型切换

| 模型 | 适合场景 |
|---|---|
| Sonnet | 日常开发 |
| Opus | 架构设计 |
| Haiku | 低成本任务 |

推荐策略：

```text
Sonnet → Opus → Haiku
```

---

# 高级分析命令

| 命令 | 作用 |
|---|---|
| /review | Code Review |
| /security-review | 安全审计 |
| /simplify | 自动重构 |
| /batch | 批量改造 |
| /plan | 输出方案但不修改代码 |

---

# /security-review 会检查什么

包括：

- SQL 注入
- XSS
- SSRF
- Prompt Injection
- Token 泄漏
- 权限问题
- 不安全依赖

上线前建议必跑。

---

# Keyboard Shortcuts

| 快捷键 | 功能 |
|---|---|
| Ctrl + C | 中断执行 |
| Ctrl + R | 搜索历史 |
| Ctrl + O | 切换详细输出 |
| Shift + Tab | 权限模式切换 |
| Esc + Esc | 撤销上次修改 |
| Shift + Enter | 多行输入 |

---

# 五、Skills 技能系统

Skills 是 Claude Code 的插件系统。

核心文件：

```text
SKILL.md
```

Claude 会自动发现并加载。

---

# 安装方式

## 官方 Marketplace

```bash
/plugin marketplace add anthropics/skills
```

安装文档处理技能：

```bash
/plugin install document-skills@anthropic-agent-skills
```

---

## 手动安装

项目级：

```text
.claude/skills/<skill-name>/SKILL.md
```

用户级：

```text
~/.claude/skills/
```

---

# SkillHub 安装

```bash
pip install skillhub
```

搜索：

```bash
skillhub search security
```

安装：

```bash
skillhub install security-review
```

---

# 推荐 Skills

## 第一梯队

| Skill | 功能 |
|---|---|
| pdf | PDF 处理 |
| xlsx | Excel 分析 |
| docx | Word 文档 |
| data-analysis | 数据分析 |

---

## 第二梯队

| Skill | 功能 |
|---|---|
| frontend-design | UI 生成 |
| refactor | 多文件重构 |
| pr-review | PR 审查 |
| security-review | 安全审计 |

---

## 第三梯队

| Skill | 功能 |
|---|---|
| seo | SEO |
| changelog | 自动生成发布日志 |
| tdd | 测试驱动开发 |
| spec | 规格说明生成 |

---

# 六、CLAUDE.md 长期记忆系统

Claude Code 每次启动都会自动读取：

```text
CLAUDE.md
```

其作用：

- 项目长期记忆
- 团队规范
- 编码规则
- 工作流约束

---

# 配置优先级

```text
CLAUDE.local.md
↓
项目 CLAUDE.md
↓
~/.claude/CLAUDE.md
```

---

# 推荐结构

```md
# 项目概述

# 技术栈

# 编码规范

# 测试命令

# 禁止事项

# Git 工作流
```

---

# 推荐规则写法

```md
IMPORTANT:
YOU MUST:
NEVER:
```

Claude 的遵循率会明显提高。

---

# 推荐模块化规则

```text
.claude/rules/
```

例如：

```text
security.md
testing.md
frontend.md
backend.md
```

---

# 最佳实践

## 不要把所有规则塞进一个文件

会污染 Context。

---

## 用 @import 拆分

例如：

```md
@rules/security.md
```

---

## 规则超过 300 行就该拆分

否则维护会变差。

---

# 七、Prompt 工程与高效提示词

真正高质量 Prompt 都有结构。

---

# OCA 原则

## Objective

目标。

---

## Context

上下文。

---

## Acceptance

验收标准。

---

# 错误 Prompt

```text
fix the bug
```

---

# 正确 Prompt

```text
src/auth.ts 的 login 函数在 token 为空时抛出 TypeError。

请：
1. 找到根因
2. 修复问题
3. 运行测试
4. 解释修改原因
```

---

# 高频 Prompt 模板

## 项目初始化

```text
请阅读 README.md、package.json 与目录结构，
理解项目架构，
暂时不要修改代码。
```

---

## 新功能开发

```text
我要开发【功能】。

步骤：
1. 阅读代码
2. 输出方案
3. 等待确认
4. 实现功能
5. 编写测试
```

---

## Bug 修复

```text
报错：
【错误】

复现步骤：
【步骤】

要求：
1. 找根因
2. 不允许绕过
3. 运行测试
```

---

# 高阶技巧

## 分步确认

复杂任务不要一次执行到底。

---

## 多 Agent 分工

不要让一个 Agent 处理所有事情。

---

## 永远先 /plan

复杂任务先规划。

---

## Prompt 越具体越好

Claude 并不会“自动理解你”。

---

# 八、MCP（Model Context Protocol）

MCP 是 Claude Code 最强大的能力之一。

它允许 Claude：

- 联网
- 调数据库
- 操作 GitHub
- 访问文件
- 控制浏览器
- 调用第三方服务

Claude Code 从聊天工具升级为：

# 自动化 AI 工作站

---

# MCP 三种模式

| 类型 | 推荐 |
|---|---|
| HTTP | ⭐⭐⭐⭐⭐ |
| Stdio | ⭐⭐⭐⭐ |
| SSE | ❌ 已弃用 |

---

# HTTP MCP 示例

```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
```

---

# Stdio MCP 示例

```bash
claude mcp add --transport stdio github -- npx -y @modelcontextprotocol/server-github
```

---

# Windows 特殊写法

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y package
```

---

# MCP 作用域

| 作用域 | 适合 |
|---|---|
| local | 单项目 |
| project | 团队共享 |
| user | 全局通用 |

---

# MCP 管理命令

```bash
claude mcp list
claude mcp get <server>
claude mcp remove <server>
```

---

# 九、五大必装 MCP

# 1. Firecrawl

网页转 Markdown。

适合：

- 调研
- 文档抓取
- 网页解析

---

# 2. GitHub MCP

直接操作：

- PR
- Issues
- 文件
- 仓库搜索

---

# 3. PostgreSQL MCP

直接查数据库。

⚠️ 永远不要连接生产库。

---

# 4. Filesystem MCP

允许跨目录访问文件。

---

# 5. Brave Search MCP

赋予 Claude 搜索能力。

---

# 十、MCP 组合实战

需求：

```text
帮我调研开源表单构建工具。
```

Claude 自动执行：

1. Brave Search 搜索候选项目
2. Firecrawl 抓取文档
3. GitHub MCP 分析活跃度
4. PostgreSQL MCP 对比数据库结构
5. Filesystem MCP 输出调研报告

整个过程无需人工干预。

---

# 十一、多 Agent 工作流

高阶用户不会只用一个 Agent。

---

# 推荐 Agent 拆分

## Agent 1

架构分析。

---

## Agent 2

功能实现。

---

## Agent 3

测试。

---

## Agent 4

安全审计。

---

## Agent 5

PR Review。

---

# 多 Agent 优势

- 更稳定
- 更低 hallucination
- 更低上下文污染
- 更高准确率

---

# 十二、Context 管理

Claude Code 的核心瓶颈：

# Context Window

---

# Context 污染来源

- 大日志
- 无关对话
- 超长 Prompt
- 大文件
- 重复信息

---

# 降低 Context 消耗的方法

- 模块化 Rules
- 多 Agent
- /compact
- CLAUDE.md
- 精简 Prompt

---

# 十三、企业级最佳实践

## 永远先 /plan

不要直接改代码。

---

## 永远写 CLAUDE.md

这是收益最高的配置。

---

## 永远最小权限

尤其 MCP Token。

---

## 永远 Git 分支开发

不要直接改 main。

---

## 永远保留人工 Review

AI 不等于生产审核。

---

# 十四、常见误区

## 误区 1

“Claude 会自动理解项目。”

错。

必须提供结构化上下文。

---

## 误区 2

“Prompt 不重要。”

错。

Prompt 决定输出质量。

---

## 误区 3

“Context 越大越好。”

错。

Context 污染会降低质量。

---

## 误区 4

“一个 Agent 就够了。”

错。

复杂任务必须拆分。

---

# 十五、推荐学习路径

## 第一阶段

学习：

- 安装
- CLI
- Slash Commands
- CLAUDE.md

---

## 第二阶段

学习：

- Skills
- /plan
- /review
- /security-review

---

## 第三阶段

学习：

- MCP
- Hooks
- 多 Agent
- 自动化工作流

---

# 十六、总结

2026 年的 Claude Code：

已经不是“AI 写代码工具”。

而是：

# AI 自动化软件工程平台

真正拉开差距的：

不是模型。

而是：

- 工作流
- Context 管理
- 长期记忆
- 多 Agent 协作
- MCP 自动化

掌握这些后：

Claude Code 不只是帮你写代码。

而是在与你一起完成整个软件工程。

