DROP TABLE IF EXISTS products_orders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;

CREATE TABLE users (
    user_UUID SERIAL PRIMARY KEY,
    user_pseudo VARCHAR(50) NOT NULL CHECK (user_pseudo <> ''),
    username VARCHAR(30) UNIQUE NOT NULL CHECK (username <> ''),
    user_password VARCHAR(80) NOT NULL CHECK (user_password <> ''),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_UUID SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL CHECK (product_name <> ''),
    product_description VARCHAR(255),
    product_price MONEY NOT NULL CHECK (product_price::numeric >= 0),
    product_quantity INTEGER NOT NULL CHECK (product_quantity >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE orders (
    order_number SERIAL PRIMARY KEY,
    user_UUID INTEGER NOT NULL,
    order_total_cost_ht MONEY NOT NULL CHECK (order_total_cost_ht::numeric > 0),
    order_total_quantity INTEGER NOT NULL CHECK (order_total_quantity > 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deliver_at TIMESTAMP,
    CONSTRAINT fk_orders_users FOREIGN KEY (user_UUID) REFERENCES users(user_UUID) ON DELETE RESTRICT
);

CREATE TABLE products_orders (
    product_UUID INTEGER NOT NULL,
    order_number INTEGER NOT NULL,
    /* quantity INTEGER NOT NULL CHECK (quantity >= 0), */
    PRIMARY KEY(product_UUID, order_number),
    CONSTRAINT fk_products_orders_products FOREIGN KEY (product_UUID) REFERENCES products(product_UUID) ON DELETE RESTRICT,
    CONSTRAINT fk_products_orders_orders FOREIGN KEY (order_number) REFERENCES orders(order_number) ON DELETE RESTRICT
);