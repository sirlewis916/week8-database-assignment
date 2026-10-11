ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Example policy: users can only see their tenant's data
-- App will SET app.current_tenant_id
CREATE POLICY tenant_isolation_users ON users USING (tenant_id = current_setting('app.current_tenant_id')::INT);
CREATE POLICY tenant_isolation_products ON products USING (tenant_id = current_setting('app.current_tenant_id')::INT);
CREATE POLICY tenant_isolation_orders ON orders USING (tenant_id = current_setting('app.current_tenant_id')::INT);

-- Least privilege roles
CREATE ROLE app_readonly NOLOGIN;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_readonly;
CREATE ROLE app_readwrite NOLOGIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_readwrite;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_readwrite;
