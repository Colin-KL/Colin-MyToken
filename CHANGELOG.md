# Changelog

所有重要的更改都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [Unreleased]

### Added
- 新增 `test_TransferFromInsufficientBalance` 测试，覆盖 transferFrom 余额不足场景
- 新增 `test_BurnInsufficientBalance` 测试，覆盖销毁超过余额场景
- 新增 `test_TransferFromInsufficientAllowance` 测试，覆盖授权额度不足场景
- 完善项目文档（架构设计、部署指南、贡献指南）

### Changed
- 优化 GitHub Actions CI 配置，添加代码格式检查和覆盖率报告
- 更新 README.md，添加详细的项目介绍和徽章

## [1.0.0] - 2026-04-15

### Added
- ✨ 初始版本发布
- 📝 ERC-20 标准代币合约实现
  - 代币名称：Colin
  - 代币符号：COL
  - 小数位：18
  - 初始供应量：100,000 COL
- 🔐 权限控制功能
  - Owner 专属铸造功能
  - 代币持有者销毁功能
- 💸 核心转账功能
  - 标准转账（transfer）
  - 授权转账（transferFrom）
  - 授权功能（approve）
- 🧪 完整的测试套件（11 个测试用例）
  - 100% 代码覆盖率
  - 包含正向和负向测试场景
- 🎨 前端管理界面
  - React + TypeScript + Next.js
  - wagmi + RainbowKit 集成
  - 代币信息展示
  - 转账功能
  - 钱包连接
- 🚀 CI/CD 自动化
  - GitHub Actions 工作流
  - 自动测试和代码检查
  - 测试覆盖率报告

### Security
- 实现重入攻击防护
- 添加整数溢出保护（Solidity 0.8+ 内置）
- 完整的权限控制机制

---

## 版本说明

### 版本号格式

版本号格式：主版本号.次版本号.修订号

- **主版本号**：不兼容的 API 更改
- **次版本号**：向后兼容的功能添加
- **修订号**：向后兼容的问题修复

### 标签说明

- `Added`：新增功能
- `Changed`：现有功能的变更
- `Deprecated`：即将移除的功能
- `Removed`：已移除的功能
- `Fixed`：Bug 修复
- `Security`：安全相关的修复

---

## 贡献

欢迎提交更改建议！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

---

## 参考

- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
