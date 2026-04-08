# 设计: 用户登录系统

## 技术方案
- 使用 JWT 作为认证 Token
- Access Token 有效期 15 分钟
- Refresh Token 有效期 7 天
- 密码使用 bcrypt 哈希
- 邮箱验证通过一次性 Token 链接

## 架构决策

### 决策 1: Token 存储方案
- **选择**: HTTP-only Cookie 存储 Refresh Token，LocalStorage 存储 Access Token
- **原因**: Refresh Token 需要防 XSS，Access Token 需要前端可访问用于 API 请求
- **替代方案**: 全部存 Cookie（CSRF 防护更复杂）、全部存 LocalStorage（XSS 风险更高）

### 决策 2: 密码哈希
- **选择**: bcrypt (cost factor 12)
- **原因**: 成熟、广泛使用、抗 GPU 暴力破解
- **替代方案**: Argon2（更新但生态不如 bcrypt 成熟）

## 数据模型

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  email_verified BOOLEAN DEFAULT FALSE,
  email_verification_token VARCHAR(255),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE refresh_tokens (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  token_hash VARCHAR(255) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
```

## 接口变更

### POST /api/auth/register
- 输入: { email, password }
- 输出: { message: "验证邮件已发送" }

### POST /api/auth/login
- 输入: { email, password }
- 输出: { accessToken, refreshToken }

### POST /api/auth/refresh
- 输入: { refreshToken }
- 输出: { accessToken, refreshToken }（轮换机制）

### POST /api/auth/logout
- 输入: { refreshToken }
- 输出: { message: "已退出" }

## 风险
1. **邮件服务依赖** — 需要配置 SMTP，开发环境可跳过验证
2. **Token 泄露** — 通过短期有效期和 HTTP-only Cookie 缓解
3. **暴力破解** — 实施速率限制和账户锁定

## 迁移方案
- 首次部署运行数据库迁移脚本
- 无破坏性变更
