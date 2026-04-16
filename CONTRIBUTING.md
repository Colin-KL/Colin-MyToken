# 贡献指南

感谢你对 Colin Token 项目的关注！本文档将指导你如何为项目做出贡献。

## 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [提交规范](#提交规范)
- [测试要求](#测试要求)
- [安全问题](#安全问题)

## 行为准则

- 尊重所有参与者
- 接受建设性批评
- 关注对社区最有利的事情
- 展现同理心

## 如何贡献

### 报告 Bug

如果你发现了 Bug，请通过 GitHub Issues 报告，并包含以下信息：

- 问题的清晰描述
- 复现步骤
- 预期行为 vs 实际行为
- 环境信息（操作系统、Node 版本等）
- 相关的代码片段或错误日志

### 提出新功能

欢迎提出新功能建议！请通过 GitHub Issues 提交，并说明：

- 功能的用例
- 预期的实现方式
- 可能的替代方案

### 提交代码

1. Fork 本仓库
2. 创建你的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'feat: add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 开发流程

### 环境设置

```bash
# 克隆仓库
git clone https://github.com/Colin-KL/Colin-MyToken.git
cd Colin-MyToken

# 安装 Foundry 依赖
forge install

# 编译合约
forge build

# 运行测试
forge test
```

### 工作流

1. **创建分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **开发和测试**
   - 编写代码
   - 添加测试
   - 确保所有测试通过

3. **代码格式化**
   ```bash
   forge fmt
   ```

4. **提交更改**
   ```bash
   git add .
   git commit -m "feat: your feature description"
   ```

5. **推送到远程**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**
   - 在 GitHub 上创建 PR
   - 描述你的更改
   - 关联相关的 Issue

## 代码规范

### Solidity 规范

- 使用 Solidity ^0.8.20
- 遵循 [Solidity Style Guide](https://docs.soliditylang.org/en/v0.8.20/style-guide.html)
- 使用有意义的变量名
- 添加注释说明复杂逻辑
- 每个函数都要有清晰的文档字符串

**示例**：
```solidity
/**
 * @notice 转账代币到指定地址
 * @param to 接收地址
 * @param amount 转账金额
 * @return 是否转账成功
 */
function transfer(address to, uint256 amount) public returns (bool) {
    require(balances[msg.sender] >= amount, "Insufficient balance");
    balances[msg.sender] -= amount;
    balances[to] += amount;
    emit Transfer(msg.sender, to, amount);
    return true;
}
```

### 测试规范

- 所有新功能必须有测试
- 测试覆盖率不能低于 90%
- 使用描述性的测试函数名
- 测试应包含正向和负向场景

**示例**：
```solidity
function test_Transfer() public {
    // 准备
    address recipient = vm.addr(1);
    uint256 amount = 1000 * 10 ** 18;
    
    // 执行
    bool success = token.transfer(recipient, amount);
    
    // 验证
    assertTrue(success);
    assertEq(token.balances(recipient), amount);
}

function test_TransferInsufficientBalance() public {
    // 准备
    address recipient = vm.addr(1);
    uint256 excessiveAmount = token.totalSupply() + 1;
    
    // 预期回滚
    vm.expectRevert("Insufficient balance");
    token.transfer(recipient, excessiveAmount);
}
```

### 前端规范

- 使用 TypeScript
- 遵循 ESLint 配置
- 使用函数式组件
- 添加适当的类型定义

## 提交规范

我们使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范。

### 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 类型

- `feat`: 新功能
- `fix`: 修复 Bug
- `docs`: 文档更新
- `style`: 代码格式（不影响功能）
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具

### 示例

```bash
# 新功能
feat: add minting functionality

# 修复 Bug
fix: correct balance calculation in transfer

# 文档更新
docs: update deployment guide

# 测试
test: add edge case tests for transfer
```

## 测试要求

### 覆盖率要求

- Lines: ≥ 90%
- Statements: ≥ 90%
- Branches: ≥ 80%
- Functions: 100%

### 运行测试

```bash
# 运行所有测试
forge test

# 运行特定测试
forge test --match-test test_Transfer

# 查看覆盖率
forge coverage

# 生成详细覆盖率报告
forge coverage --report lcov
```

### 持续集成

所有 Pull Request 必须通过 CI 检查：
- 代码格式检查
- 合约编译
- 所有测试通过
- 覆盖率检查

## 安全问题

### 报告安全漏洞

如果你发现了安全漏洞，请不要在公共 Issue 中报告。请发送邮件到：

**security@example.com**

包含以下信息：
- 漏洞描述
- 复现步骤
- 可能的影响
- 建议的修复方案（如果有）

### 安全最佳实践

- 永远不要将私钥提交到代码仓库
- 使用 `.env` 文件存储敏感信息
- 定期更新依赖包
- 遵循 [Consensys 安全最佳实践](https://consensys.github.io/smart-contract-best-practices/)

## 获取帮助

如果你需要帮助，可以通过以下方式：

- 查看 [文档](docs/)
- 在 GitHub Discussions 中提问
- 加入我们的社区（如果有）

## 许可证

通过贡献代码，你同意你的贡献将在 MIT 许可证下发布。

---

感谢你的贡献！🎉
