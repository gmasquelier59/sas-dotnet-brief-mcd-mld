
/*
A décommenter pour révoquer tous les privilèges et les rôles existants associés à la boutique

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM store_manager;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM store_manager_users;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM store_manager_products;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM store_manager_orders;
DROP ROLE IF EXISTS store_manager;
DROP ROLE IF EXISTS store_manager_users;
DROP ROLE IF EXISTS store_manager_products;
DROP ROLE IF EXISTS store_manager_orders;
*/

CREATE ROLE store_manager LOGIN NOCREATEDB NOSUPERUSER;
CREATE ROLE store_manager_users LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER;
CREATE ROLE store_manager_products LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER;
CREATE ROLE store_manager_orders LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER;

GRANT SELECT ON users, products, orders, products_orders TO store_manager;
GRANT SELECT ON users, products, orders, products_orders TO store_manager_users;
GRANT SELECT ON users, products, orders, products_orders TO store_manager_products;
GRANT SELECT ON users, products, orders, products_orders TO store_manager_orders;

GRANT INSERT, UPDATE, DELETE ON users, products, orders, products_orders TO store_manager;
GRANT INSERT, UPDATE, DELETE ON users TO store_manager_users;
GRANT INSERT, UPDATE, DELETE ON products TO store_manager_products;
GRANT INSERT, UPDATE, DELETE ON orders, products_orders TO store_manager_orders;