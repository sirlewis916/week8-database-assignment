# NoSQL Choice: Redis for Cart & Cache

**Store Chosen:** Redis (in-memory key-value)

**Why not PostgreSQL for this part?**
- Shopping cart needs <10ms read/write per user, thousands of concurrent users
- Cart data is ephemeral (expires in 24h), no need for ACID joins or RLS
- PostgreSQL would create heavy row locks on products table during cart updates

**Problem Redis solves better:**
- Session cart: `SET cart:{user_id} {json} EX 86400` - O(1) speed
- Cache hot products: `GET product:{id}` avoids 1000s of SELECTs
- Rate limiting / ingestion buffer for orders

**Implementation (pseudo):**
- On add to cart: redis.setex(`cart:${userId}`, 86400, JSON.stringify(cart))
- On checkout: read from Redis, write final order to Postgres, then del cart
