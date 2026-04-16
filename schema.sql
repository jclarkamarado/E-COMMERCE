-- E-Commerce demo schema (MySQL)
-- WARNING: This script drops existing tables in the currently-selected database.
-- Run it only in a fresh/dev database.

-- (Optionally) run: USE your_database_name;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  google_id VARCHAR(255) NULL UNIQUE,
  google_email VARCHAR(255) NULL,
  google_name VARCHAR(255) NULL,
  google_picture VARCHAR(1024) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE,
  description TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  slug VARCHAR(160) NOT NULL UNIQUE,
  description TEXT NULL,
  price DECIMAL(10,2) NOT NULL,
  image VARCHAR(255) NULL,
  stock INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_products_category
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  status ENUM('pending','processing','shipped','completed','cancelled') NOT NULL DEFAULT 'pending',
  total_amount DECIMAL(10,2) NOT NULL,
  shipping_address TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NULL,
  product_name VARCHAR(200) NOT NULL,
  qty INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_items_order
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_items_product
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed data
INSERT INTO users (id, name, email, password_hash, role) VALUES
  (1, 'Admin', 'admin@example.com', '$2y$10$ZYKMVQovB.DyTdPILzoL8equjwLNV93ufyxxjBYdqz4.vY4//KZDK', 'admin');

INSERT INTO categories (id, name, slug, description) VALUES
  (1, 'ARAI', 'arai', 'Premium ARAI helmets'),
  (2, 'KYT', 'kyt', 'Stylish KYT helmets'),
  (3, 'SPYDER', 'spyder', 'High-visibility SPYDER helmets');

INSERT INTO products (id, category_id, name, slug, description, price, image, stock) VALUES
  (1, 1, 'ARAI RX6', 'arai-rx6', 'Street-ready performance.', 12999.00, 'ARAI - RX6.jpg', 12),
  (2, 1, 'ARAI RX7', 'arai-rx7', 'Comfort-fit touring design.', 9999.00, 'ARAI - RX7.jpg', 10),
  (3, 1, 'ARAI RX8', 'arai-rx8', 'Aerodynamic daily rider.', 10999.00, 'ARAI - RX8.jpg', 8),
  (4, 2, 'KYT R2R', 'kyt-r2r', 'Compact and lightweight.', 4999.00, 'KYT R2R.jpg', 14),
  (5, 2, 'KYT TT REVO', 'kyt-tt-revo', 'Bold graphics edition.', 5599.00, 'KYT TT REVO.jpg', 9),
  (6, 2, 'KYT TTC', 'kyt-ttc', 'Ventilated airflow system.', 4799.00, 'KYT TTC.jpg', 7),
  (7, 3, 'SPYDER ASTRA', 'spyder-astra', 'Everyday visibility and style.', 3199.00, 'SPYDER - ASTRA.jpg', 16),
  (8, 3, 'SPYDER NEO ICON', 'spyder-neo-icon', 'Clean silhouette, modern comfort.', 3599.00, 'SPYDER - NEO ICON.jpg', 6),
  (9, 3, 'SPYDER ROGUE', 'spyder-rogue', 'Durable build for city rides.', 2899.00, 'SPYDER - ROGUE.jpg', 11);

