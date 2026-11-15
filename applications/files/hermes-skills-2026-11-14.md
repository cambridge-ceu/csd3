# Hermes Agent：值得优先安装的 53 个营销技能及Google实用插件

**2026 年 11 月 14 日**

Hermes Agent 的发展不应仅仅通过版本号来衡量。尽管目前最新稳定版仍为 **v0.23.1**，v0.24 尚未正式发布，桌面端、Web 端和移动端的一系列改进也仍在推进，但其技能（Skills）和插件（Plugins）生态已经提供了不少可以直接投入使用的功能。

对于日常工作而言，这一点可能比版本升级更值得关注。

例如，过去使用 AI 撰写社交媒体内容、优化电商商品详情页或规划公众号文章时，往往需要反复提供产品背景、目标受众、品牌定位和写作风格等信息。通过安装专门的技能，可以将这些工作方法和操作规范预先封装起来，让 Agent 按照既定流程完成任务，而不必每次从头开始。

换句话说，**Agent 的实际能力不仅取决于模型和软件版本，也取决于它所具备的技能、工具以及与外部服务的集成能力。**

下面介绍五项值得关注的技能和插件。

## 一、53 个营销技能：值得优先尝试的开源资源

首先推荐的是 Corey Haines 发布的开源项目 [Marketing Skills](https://github.com/coreyhaines31/marketingskills)。

该项目包含 53 个营销相关技能，采用 MIT 开源许可证。它并非 Nous Research 官方发布的 Hermes Agent 技能包，而是一个可以供多种兼容 Agent 使用的第三方技能集合。

其 GitHub 项目具有较高的社区关注度。需要注意的是，项目的 Star 数量反映的是整个开源项目的受欢迎程度，并非 Hermes Agent 用户数量。

安装命令：

```bash
npx skills add coreyhaines31/marketingskills -a hermes-agent -g
```

安装后，可以优先使用 `/product-marketing`，建立产品定位、目标客户、品牌语气等基础信息。后续撰写文案、开展 SEO 优化、分析定价策略和改善转化率时，就可以复用这些背景信息。

53 个技能覆盖的营销工作可以用于：

- **内容营销：** 社交媒体文案、博客文章及内容规划。
- **产品营销：** 产品定位、价值主张和目标客户分析。
- **搜索优化：** SEO 策略、关键词研究和网站内容优化。
- **电商运营：** 商品详情页、营销标题及转化率优化。
- **商业分析：** 定价策略、竞争分析和营销效果评估。

例如，可以让 Hermes Agent 根据既定品牌定位，生成小红书封面标题、优化淘宝商品详情页，或者拟定微信公众号文章的开头。

与每次重新解释需求相比，这种基于统一规范的工作方式更容易保持内容的一致性。

## 二、Google Workspace：打通邮件、日历和办公文档

Google Workspace 是 Hermes Agent 值得关注的一项办公集成能力，支持 Gmail、Google Calendar、Google Drive、Google Docs、Google Sheets 和 Google Contacts。

需要特别说明的是：**Google Workspace 在 Hermes 中属于 Skill（技能），而不是需要通过 `hermes plugins install` 安装的普通插件。**

在 Hermes Agent v0.23.0 中，可以通过以下命令查看：

```bash
hermes skills list
```

如果已经启用，列表中会出现类似记录：

```text
google-workspace    productivity    builtin    builtin    enabled
```

这表示该技能已经作为 Hermes 的内置技能提供，无须再从插件目录重复安装。

### 功能与执行方式

Google Workspace 技能可以通过两种方式执行相关操作：

- **gws CLI**：如果系统已安装 Google Workspace CLI，技能可以优先使用它，以获得更广泛的服务覆盖。
- **Python 客户端**：如果没有安装 `gws`，则可以使用技能附带的 Python 实现。

因此，它不仅能辅助生成邮件和文档内容，还可以在完成授权后，结合 Gmail、日历和云端文件开展实际工作。

### 首次配置：Google OAuth 授权

安装或启用技能，并不意味着 Hermes 已经能够访问 Google 账号。用户仍需配置 Google OAuth 凭据并完成授权。

技能提供了专门的配置脚本：

```text
~/.hermes/skills/productivity/google-workspace/scripts/setup.py
```

可以先查看支持的操作：

```bash
python "$HERMES_HOME/skills/productivity/google-workspace/scripts/setup.py" --help
```

主要选项包括：

| 参数 | 用途 |
|---|---|
| `--check` | 检查现有授权状态 |
| `--check-live` | 通过实际 API 请求检查授权 |
| `--client-secret PATH` | 保存 Google OAuth 客户端凭据 |
| `--auth-url` | 生成授权 URL |
| `--auth-code CODE` | 使用授权码换取访问令牌 |
| `--revoke` | 撤销并删除已保存的令牌 |
| `--install-deps` | 安装所需 Python 依赖 |

配置过程中需要准备两个凭据文件：

```text
google_client_secret.json
google_token.json
```

前者来自 Google Cloud Console 中创建的 OAuth 客户端，后者由授权流程生成。用户需要根据实际使用的服务启用相应 Google APIs，并完成 OAuth 同意及账号授权。

### HPC 环境中的注意事项

对于运行在共享 HPC 集群上的 Hermes，建议将 OAuth 凭据保存在个人目录：

```text
~/.hermes/
```

不要将个人 Google 账号凭据放入共享的软件模块目录。也不应在尚未检查依赖的情况下直接运行 `--install-deps`，以免影响现有 Hermes Python 环境。

Google Workspace 集成由 Hermes 技能实现，并非 Google 官方推出的 Hermes 产品。用户应根据自己的使用需求和授权范围决定是否启用。

对于经常处理邮件、会议和办公文档的用户，这项能力值得尝试；但应先完成 OAuth 配置，再验证实际 API 访问是否正常。

## 三、/steer：不中断当前任务，动态调整执行方向

`/steer` 是 Hermes Agent 中一个很实用的交互功能。

在 Agent 正在执行任务时，用户可能突然想到需要补充的要求。例如，正在撰写一篇公众号文章时，希望开头更简洁，或者增加面向非专业读者的解释。

使用 `/steer` 可以将新的指令加入当前任务。Agent 会在下一次工具调用完成后读取这些补充要求，而不必立即终止当前工作，也不需要重新启动一轮任务。

它与 `/queue` 的区别在于：

- `/steer`：调整当前任务的执行方向。
- `/queue`：将新任务排入后续执行队列。
- 直接中断：停止当前执行，再重新提交任务。

例如：

```text
/steer 开头写得更简洁一些，优先考虑非专业读者的理解。
```

这对于长时间运行的任务尤其有用，可以减少重复执行和上下文重新整理的开销。

另外，有用户提到手机测试版本 Build 44 已经出现 `/steer`。但这属于社区反馈，不能据此认定该功能已经随正式手机版发布。

## 四、X Bookmarks：让收藏的内容重新发挥价值

X Bookmarks 插件由社区开发者 winch 创建，项目名称为 `hermes-x-bookmarks`。

安装命令：

```bash
hermes plugins install hermes-x-bookmarks
```

它的主要用途是整理 X（原 Twitter）上的书签，将长期积累却很少重新阅读的内容转化为可利用的信息资源。

根据项目介绍，其功能包括：

- 收集和整理 X 书签。
- 生成定期内容摘要。
- 将重要帖子转化为待办事项。
- 将收藏内容整理成新的技能或知识资料。
- 将整理结果同步到 Notion、文档或本地文件。

这类功能的价值不仅在于自动整理收藏夹，更在于将零散的信息转化为可以检索、归纳和继续使用的知识。

不过，插件并不是安装后就能直接读取 X 账号内容。用户需要自行准备 X Developer 应用及相应 API 凭据，并完成必要的授权配置。

## 五、Hermes Whiteboard：以可视化方式规划任务

Hermes Whiteboard 是另一项值得关注的工具。

它的主要思路是将复杂任务转化为可视化的工作流程：用户提出目标，Agent 生成执行计划，再按照计划逐步推进。

例如，对于一项涉及资料收集、分析、撰写和结果整理的任务，可以先通过白板查看整体步骤，再逐项执行。

这种方式尤其适合：

- 多阶段研究项目。
- 内容生产和发布流程。
- 软件开发及调试任务。
- 需要多个步骤协同完成的工作。

桌面端已经可以使用该工具。有关安装和具体操作，可以参考此前的 Hermes Whiteboard 介绍。

## 六、v0.23.1 更新及后续版本展望

尽管 v0.24 尚未正式发布，v0.23.1 仍然带来了一项值得注意的改进。

根据官方发布说明，插件目录的体积限制从原来的 **2 MB 提高到了 16 MB**。

这对于包含更多资源文件或复杂实现的插件尤其有用，也能减少因插件目录体积限制而产生的安装问题。

不过，桌面安装包尚未同步完成这一更新，需要等待下一次重新打包发布。

至于移动端，官方此前提到的目标是争取在圣诞节前推出。联合创始人也曾表示相关工作正在推进，但这并不意味着已经确定正式发布日期。

桌面端和 Web 端的大幅改版同样需要等待官方正式发布，不能将预告图或社区测试信息视为已经上线的功能。

## 七、总结：与其等待升级，不如先完善技能生态

从目前的情况来看，Hermes Agent 的发展可以从两个方面理解：

一方面是软件本身的持续升级，包括桌面端、Web 端、移动端以及核心功能的改进；另一方面是技能和插件生态的不断完善，使 Agent 能够真正融入日常工作。

本文介绍的五项资源各有侧重：

| 资源 | 主要用途 | 类型 |
|---|---|---|
| Marketing Skills | 营销、SEO、内容创作 | 第三方技能库 |
| Google Workspace | 邮件、日历和办公文档 | 社区插件 |
| /steer | 动态调整当前任务 | Agent 功能 |
| X Bookmarks | 收藏整理和知识管理 | 社区插件 |
| Hermes Whiteboard | 可视化任务规划 | 工具 |

其中，Marketing Skills 适合内容创作和营销工作；Google Workspace 适合希望打通办公流程的用户；`/steer` 则能改善日常交互体验。

**真正值得关注的，并不是 Hermes Agent 何时从 v0.23 升级到 v0.24，而是如何利用现有的技能和插件，让它从一个能够回答问题的 AI 助手，逐步变成能够按照既定流程完成实际工作的 Agent。**

版本升级有官方的时间表，技能生态则可以由用户主动扩展。

与其一味等待下一个版本，不如先从最符合自己工作需求的技能开始尝试。
