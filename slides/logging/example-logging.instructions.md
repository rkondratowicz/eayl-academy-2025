---
applyTo: "**"
---

# Logging Best Practices Instructions

Use these guidelines when refactoring or implementing logging in backend and frontend applications.

## General Principles

1. **Use Structured Logging**: Always log objects with context, not plain strings
2. **Appropriate Log Levels**: Use the correct level for each situation
3. **Security First**: Never log sensitive information
4. **Environment Awareness**: Different logging behavior for development vs production

## Log Levels Guide

```
FATAL/CRITICAL - Application cannot continue (use sparingly)
ERROR          - Something failed that needs attention
WARN           - Unexpected situation but handled
INFO           - Important business events (default for production)
DEBUG          - Detailed diagnostic information (development only)
TRACE          - Very detailed diagnostic (development only)
```

## Backend (Express) Logging

### Request/Response Middleware

Always add middleware to log incoming requests:

```javascript
app.use((req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    logger.info('HTTP Request', {
      method: req.method,
      url: req.url,
      statusCode: res.statusCode,
      duration: `${duration}ms`,
      userAgent: req.get('user-agent'),
      ip: req.ip
    });
  });
  
  next();
});
```

### Error Handling Middleware

Add comprehensive error logging:

```javascript
app.use((err, req, res, next) => {
  logger.error('Unhandled error', {
    error: err.message,
    stack: err.stack,
    method: req.method,
    url: req.url,
    userId: req.user?.id,
    requestId: req.id
  });
  
  // Never expose internal errors to client
  res.status(err.status || 500).json({
    error: 'Internal server error',
    requestId: req.id
  });
});
```

### Route Handlers

Log important business events:

```javascript
router.post('/api/orders', async (req, res) => {
  try {
    const order = await createOrder(req.body);
    
    logger.info('Order created', {
      orderId: order.id,
      userId: req.user.id,
      amount: order.total,
      items: order.items.length
    });
    
    res.json(order);
  } catch (error) {
    logger.error('Failed to create order', {
      error: error.message,
      userId: req.user.id,
      body: sanitizeBody(req.body)
    });
    throw error;
  }
});
```

### Security: Sanitize Sensitive Data

Always sanitize request bodies before logging:

```typescript
function sanitizeBody(body: any): any {
  const sanitized = { ...body };
  const sensitiveFields = [
    'password', 
    'token', 
    'secret', 
    'apiKey', 
    'creditCard',
    'ssn',
    'authorization'
  ];
  
  sensitiveFields.forEach(field => {
    if (sanitized[field]) {
      sanitized[field] = '[REDACTED]';
    }
  });
  
  return sanitized;
}
```

## Frontend (TypeScript) Logging

### Create a Logger Utility

```typescript
// utils/logger.ts
type LogLevel = 'debug' | 'info' | 'warn' | 'error';

const shouldLog = (level: LogLevel): boolean => {
  if (process.env.NODE_ENV === 'production') {
    return ['error', 'warn'].includes(level);
  }
  return true;
};

export const logger = {
  debug: (...args: any[]) => {
    if (shouldLog('debug')) {
      console.debug('[DEBUG]', ...args);
    }
  },
  info: (...args: any[]) => {
    if (shouldLog('info')) {
      console.info('[INFO]', ...args);
    }
  },
  warn: (...args: any[]) => {
    if (shouldLog('warn')) {
      console.warn('[WARN]', ...args);
    }
  },
  error: (...args: any[]) => {
    if (shouldLog('error')) {
      console.error('[ERROR]', ...args);
    }
  }
};
```

### Global Error Handling

```typescript
// Catch unhandled errors in the browser
window.addEventListener('error', (event: ErrorEvent) => {
  logger.error('Unhandled error', {
    error: event.error?.message,
    stack: event.error?.stack,
    filename: event.filename,
    lineno: event.lineno,
    colno: event.colno,
    timestamp: new Date().toISOString()
  });
  
  // Optionally send to logging service in production
  if (process.env.NODE_ENV === 'production') {
    // sendToLoggingService(event.error);
  }
});

// Catch unhandled promise rejections
window.addEventListener('unhandledrejection', (event: PromiseRejectionEvent) => {
  logger.error('Unhandled promise rejection', {
    reason: event.reason,
    timestamp: new Date().toISOString()
  });
});
```

### API Call Logging

```typescript
// Setup axios interceptors
axios.interceptors.request.use(
  config => {
    logger.debug('API Request', {
      method: config.method,
      url: config.url,
      timestamp: new Date().toISOString()
    });
    return config;
  },
  error => {
    logger.error('API Request Error', {
      error: error.message,
      config: error.config
    });
    return Promise.reject(error);
  }
);

axios.interceptors.response.use(
  response => {
    logger.debug('API Response', {
      status: response.status,
      url: response.config.url,
      duration: response.headers['x-response-time']
    });
    return response;
  },
  error => {
    logger.error('API Error', {
      status: error.response?.status,
      url: error.config?.url,
      message: error.message,
      data: error.response?.data
    });
    return Promise.reject(error);
  }
);
```

### User Interaction Logging

```typescript
// Log important user interactions
async function handleLogin(credentials: LoginCredentials): Promise<void> {
  try {
    logger.info('User login attempt', {
      email: credentials.email,
      timestamp: new Date().toISOString()
    });
    
    const user = await loginAPI(credentials);
    
    logger.info('User logged in successfully', {
      userId: user.id,
      email: user.email
    });
    
    // Navigate to dashboard
    window.location.href = '/dashboard';
  } catch (error) {
    logger.error('Login failed', {
      error: (error as Error).message,
      email: credentials.email
    });
    displayError('Login failed');
  }
}
```

## What to Log

### ✅ DO Log

- Application startup/shutdown events
- User authentication events (login, logout, registration)
- Business transactions (orders, payments, bookings)
- External API calls and their responses
- Database connection issues
- Configuration changes
- All errors and exceptions with context
- Slow operations (> 1 second)
- Security events (failed auth attempts, permission denials)

### ❌ DON'T Log

- Passwords, tokens, API keys, secrets
- Credit card numbers (only last 4 digits if needed)
- Social security numbers or other PII
- Session tokens or JWT contents
- Authorization headers
- Every function entry/exit (too verbose)
- Temporary loop variables
- Internal implementation details in production

## Environment Configuration

### Backend (.env)

```bash
# Development
NODE_ENV=development
LOG_LEVEL=debug

# Production
NODE_ENV=production
LOG_LEVEL=info
```

### Frontend

```typescript
// config/logging.ts
export const loggingConfig = {
  level: process.env.NODE_ENV === 'production' ? 'error' : 'debug',
  enableConsole: process.env.NODE_ENV !== 'production',
  enableRemote: process.env.NODE_ENV === 'production'
};
```

## Refactoring Checklist

When refactoring existing code:

- [ ] Replace `console.log` with structured logger calls
- [ ] Add appropriate log levels
- [ ] Remove or sanitize any sensitive data from logs
- [ ] Add context objects to all log statements
- [ ] Implement request/response logging middleware (backend)
- [ ] Add error boundary with logging (frontend)
- [ ] Set up environment-specific logging configuration
- [ ] Add API interceptors for request/response logging (frontend)
- [ ] Remove overly verbose debug logs
- [ ] Ensure error logs include stack traces
- [ ] Add timestamps to custom logs
- [ ] Group related logs where appropriate

## Testing Your Logging

1. **Check log output** in development - ensure logs are readable
2. **Test in production mode** - verify sensitive data isn't logged
3. **Trigger errors** - confirm errors are logged with full context
4. **Review log volume** - ensure not too verbose in production
5. **Search logs** - test that you can find specific events easily

## Recommended Libraries

### Backend
- **Winston**: Flexible, popular, many transports
- **Pino**: Fast, low overhead, JSON-focused
- **Morgan**: HTTP request logger middleware

### Frontend
- **loglevel**: Simple, lightweight, cross-browser
- **debug**: Namespaced debug logging
- **Custom wrapper** around console (as shown above)

## Example: Before vs After

### Before (Poor Logging)

```typescript
// Backend
app.post('/api/login', (req, res) => {
  console.log('Login attempt');
  console.log(req.body); // Logs password!
  // ... rest of code
});

// Frontend
function handleLogin() {
  console.log('rendering');
  console.log(formData); // Logs password!
}
```

### After (Good Logging)

```typescript
// Backend
app.post('/api/login', async (req: Request, res: Response) => {
  logger.info('Login attempt', {
    email: req.body.email,
    ip: req.ip,
    timestamp: new Date().toISOString()
  });
  
  try {
    const user = await authenticate(req.body);
    logger.info('User logged in', {
      userId: user.id,
      email: user.email
    });
    res.json({ user });
  } catch (error) {
    logger.error('Login failed', {
      email: req.body.email,
      error: (error as Error).message,
      ip: req.ip
    });
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

// Frontend
async function handleLoginSubmit(formData: LoginForm): Promise<void> {
  try {
    logger.info('Login attempt', {
      email: formData.email
    });
    
    const user = await loginAPI(formData);
    
    logger.info('Login successful', {
      userId: user.id
    });
    
    window.location.href = '/dashboard';
  } catch (error) {
    logger.error('Login failed', {
      error: (error as Error).message
    });
    displayError('Login failed');
  }
}
```

## When to Use Copilot

Use GitHub Copilot to help you:
1. Convert console.log statements to structured logs
2. Add sanitization functions for sensitive data
3. Implement logging middleware
4. Create error handlers with logging
5. Add appropriate log levels to existing logs
6. Generate logger utility functions

Simply select code and ask Copilot to "refactor this with proper structured logging following logging best practices".
