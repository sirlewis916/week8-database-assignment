# SECURITY.md - Capstone Project Security Implementation

### 1. Least-Privilege Roles
**Status: [x] Implemented in V4_row_level_security.sql**
- No application uses `postgres` superuser
- Created:
```sql
CREATE ROLE app_readonly NOLOGIN;
CREATE ROLE app_writer NOLOGIN;
CREATE ROLE app_user LOGIN PASSWORD 'SecureApp123!' IN ROLE app_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_writer;
