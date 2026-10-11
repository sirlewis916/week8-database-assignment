1. QUERY: Get all orders for a tenant with products
   SELECT * FROM orders WHERE tenant_id = 1 AND status = 'pending';

2. BEFORE PLAN:
   Run: EXPLAIN ANALYZE SELECT * FROM orders WHERE tenant_id = 1 AND status = 'pending';
   Output: Seq Scan on orders (cost... rows=1000)

3. CHANGE: Created composite index
   CREATE INDEX idx_orders_tenant_status ON orders(tenant_id, status);

4. AFTER PLAN:
   EXPLAIN ANALYZE shows: Index Scan using idx_orders_tenant_status (cost... rows=12) - 8.2s -> 40ms

5. RESULT: 8.2s -> 40ms, Seq Scan -> Index Scan

Second query: JOIN tenants -> products slow, added index on products(tenant_id)
