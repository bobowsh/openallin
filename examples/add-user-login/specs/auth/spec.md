# Auth 模块增量规格

## ADDED Requirements

### Requirement: Token 刷新
系统 MUST 支持通过 refresh token 获取新的 access token。

#### Scenario: 有效刷新
- GIVEN 用户持有未过期的 refresh token
- WHEN 用户请求刷新
- THEN 返回新的 access token
- AND 返回新的 refresh token（轮换）

#### Scenario: 过期 Token
- GIVEN refresh token 已过期
- WHEN 用户请求刷新
- THEN 返回"Token 已过期"错误
- AND 需要重新登录

### Requirement: 用户登出
系统 MUST 支持用户主动登出。

#### Scenario: 正常登出
- GIVEN 用户持有有效的 refresh token
- WHEN 用户请求登出
- THEN 使 refresh token 失效
- AND 返回"已退出"消息

---

## MODIFIED Requirements

### Requirement: 用户注册
系统 MUST 支持用户通过邮箱和密码注册。

#### Scenario: 有效注册
- GIVEN 用户提供有效邮箱和符合要求的密码
- WHEN 用户提交注册表单
- THEN 创建未验证账户
- AND 发送验证邮件
- AND 返回"验证邮件已发送"消息

（原: 系统 MUST 支持用户通过邮箱注册。未提及密码要求和响应消息。）

#### Scenario: 邮箱已存在
- GIVEN 邮箱已被注册
- WHEN 用户尝试注册
- THEN 返回"邮箱已存在"错误
- AND 不创建新记录

### Requirement: 用户登录
系统 SHALL 在用户验证身份后颁发 JWT Token。

#### Scenario: 有效凭证
- GIVEN 用户拥有已验证的有效账户
- WHEN 用户提交正确的邮箱和密码
- THEN 返回 JWT access token（15分钟有效期）
- AND 返回 refresh token（7天有效期）

（原: 返回 JWT access token 和 refresh token，未指定有效期。）

#### Scenario: 未验证邮箱
- GIVEN 用户邮箱未验证
- WHEN 用户尝试登录
- THEN 返回"请先验证邮箱"错误
