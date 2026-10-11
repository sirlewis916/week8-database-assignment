INSERT INTO tenants (name) VALUES ('Garissa Mart'), ('Nairobi Store');

INSERT INTO users (tenant_id, email, password_hash, role) VALUES
(1, 'dennis@test.com', '$2b$12$hashedpassword', 'admin'),
(1, 'customer1@test.com', '$2b$12$hashedpassword2', 'customer');

INSERT INTO products (tenant_id, name, price, stock, attributes) VALUES
(1, 'Laptop HP', 75000.00, 10, '{"color": "silver", "ram": "8GB"}'),
(1, 'Phone Samsung', 45000.00, 25, '{"color": "black", "storage": "128GB"}'),
(2, 'Maize Flour', 200.00, 100, '{"weight": "2kg"}');

INSERT INTO orders (tenant_id, user_id, total_amount, status) VALUES (1, 2, 75000.00, 'paid');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 75000.00);
