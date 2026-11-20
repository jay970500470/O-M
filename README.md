# DSH Desktop Profile 备份

DeepSeek Harness 桌面版 `desktop` profile 的配置版本控制。

## 用途

DSH 升级、插件重装时，profile 配置可能被覆盖或改写。此仓库用于：

- 升级前打点（commit），升级后 `git diff` 精确查看改了什么
- 配置丢失时按文件精确恢复，而非整体回滚
- 保留历史配置快照

## 目录说明

本仓库跟踪 `%USERPROFILE%\.dsh\profiles\desktop\` 下的文本配置：

| 文件 | 作用 |
|---|---|
| `cordis.patch.yml` | **核心**：profile 补丁层，手工配置（模型、UI、插件参数）都在这里 |
| `package.json` | profile 元数据：启用哪些 bundle、依赖哪些插件 |
| `pnpm-lock.yaml` | 插件依赖锁定版本 |
| `pnpm-workspace.yaml` | pnpm 工作区配置 |
| `cordis.yml` | profile 入口（通常为空数组，实际配置都在 patch 层） |
| `cordis.patch.yml.*.bak` | 历史手工备份 |

**不跟踪**：`node_modules/`、`.plugin-manager/`（可由 pnpm 重建）。

## 安全

已扫描确认：本仓库**不含任何明文密钥**。

- 密钥通过环境变量引用（如 `apiKeyEnv: TOKENPLAN_API_KEY`），文件里只有变量名
- 推送前扫描了 `password` / `secret` / `apiKey` / `sk-*` / `ghp_*` / `AKIA*` 等模式，0 命中

## 用法

### 升级前打点

```powershell
cd $env:DSH_PROFILE_DIR
git add -A
git commit -m "before: 升级到 DSH x.y.z"
```

### 升级后对比

```powershell
git diff HEAD~1
```

### 恢复某个文件

```powershell
git checkout HEAD~1 -- cordis.patch.yml
```

### 恢复全部

```powershell
git reset --hard HEAD~1
```

## 注意

- `dsh-connect-workbuddy` 插件会把自己的运行时状态（模型目录 `lastCatalog`）写进 `cordis.patch.yml`，所以这个文件经常变化，属正常现象
- 恢复后需重启 DSH 才生效
