# 任务清单: 用户登录系统

> 按顺序勾选并执行，不要偏离清单。

## Wave 1: 基础设施
- [ ] Task 1: 创建数据库迁移文件
  - 文件: migrations/001_create_users.sql, migrations/002_create_refresh_tokens.sql
  - 验证: 迁移脚本可成功执行

- [ ] Task 2: 配置邮件服务
  - 文件: config/mail.ts, services/mailService.ts
  - 验证: 可以发送测试邮件

## Wave 2: 核心功能
- [ ] Task 3: 实现用户注册
  - 文件: services/authService.ts, routes/auth.ts
  - 验证: 注册接口返回正确响应，数据库创建记录
  - 依赖: Task 1, Task 2

- [ ] Task 4: 实现邮箱验证
  - 文件: services/authService.ts, routes/auth.ts
  - 验证: 点击验证链接后邮箱状态更新
  - 依赖: Task 3

- [ ] Task 5: 实现用户登录
  - 文件: services/authService.ts, routes/auth.ts
  - 验证: 登录接口返回 JWT tokens
  - 依赖: Task 3

## Wave 3: Token 管理
- [ ] Task 6: 实现 Token 刷新
  - 文件: services/tokenService.ts, routes/auth.ts
  - 验证: 刷新接口返回新 tokens，旧 token 失效
  - 依赖: Task 5

- [ ] Task 7: 实现用户登出
  - 文件: services/authService.ts, routes/auth.ts
  - 验证: 登出后 refresh token 失效
  - 依赖: Task 6

## Wave 4: 安全与收尾
- [ ] Task 8: 添加认证中间件
  - 文件: middleware/auth.ts
  - 验证: 未认证请求被正确拦截

- [ ] Task 9: 添加速率限制
  - 文件: middleware/rateLimit.ts
  - 验证: 超出限制返回 429

- [ ] Task 10: 编写测试
  - 文件: tests/auth.test.ts
  - 验证: 所有测试通过

- [ ] 更新 API 文档
- [ ] 运行全部测试
- [ ] 运行 lint 和 typecheck
- [ ] 确认无调试代码
- [ ] 确认无敏感信息泄露
