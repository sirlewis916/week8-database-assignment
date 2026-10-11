# PLP Capstone Project - Database Design, Migration & Security

**Student:** Dennis | **Track:** Database | **Date:** Oct 11, 2026
**Google Doc Documentation:**https://docs.google.com/document/d/1ZJDKGpuSWNRnp3oxnArANjputfX5t0YqtmHn61u_1Xo/edit?usp=sharing

---

## 1. Project Overview
Multi-tenant e-commerce database with full migration history, Row Level Security (RLS), audit logging, and verified backups.

## 2. ER Diagram
![ER Diagram](er_diagram.png)

**Tables:**
- `tenants` (id PK, name) - Root tenant isolation
- `users` (id PK, tenant_id FK, email, password_hash)
- `products` (id PK, tenant_id FK, name, price)
- `orders` (id PK, tenant_id FK, user_id FK, product_id FK, total, status)
- `audit_log` (id PK, table_name, operation, old_data JSONB, new_data JSONB, changed_by, changed_at)

**Relationships:**
- tenants 1:N users
- tenants 1:N products
- tenants 1:N orders
- users 1:N orders

## 3. Migration Files (V1-V5)
- `V1__core_tables.sql` - Creates all core tables with FK constraints
- `V2__indexes.sql` - Indexes on tenant_id, user_id for performance
- `V3__audit_and_triggers.sql` - audit_log table + log_audit() trigger function
- `V4__row_level_security.sql` - Roles app_readonly/app_writer + RLS policies
- `V5__seed_demo_data.sql` - Sample tenants, users, products, orders

Run: `flyway migrate` or `psql -f V1...`

## 4. Security Implementation (6/6 PASSED)

### [x] 1. Least-Privilege Roles
```sql
CREATE ROLE app_readonly NOLOGIN;
CREATE ROLE app_writer NOLOGIN;
CREATE ROLE app_user LOGIN PASSWORD '***' IN ROLE app_writer;