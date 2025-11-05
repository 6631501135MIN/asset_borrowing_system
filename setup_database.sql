-- Create database
DROP DATABASE IF EXISTS asset_management;
CREATE DATABASE asset_management;
USE asset_management;

-- Users table
CREATE TABLE users (
  uid INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  ph_num VARCHAR(20),
  username VARCHAR(50) UNIQUE NOT NULL,
  profile_img VARCHAR(255) DEFAULT 'default.png',
  role ENUM('student', 'admin') DEFAULT 'student',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Category table
CREATE TABLE category (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  image VARCHAR(255),
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Asset table
CREATE TABLE asset (
  asset_id INT PRIMARY KEY AUTO_INCREMENT,
  asset_code VARCHAR(50) UNIQUE NOT NULL,
  asset_name VARCHAR(200) NOT NULL,
  category_id INT NOT NULL,
  status ENUM('available', 'pending', 'borrowed', 'maintenance') DEFAULT 'available',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Borrowing table
CREATE TABLE borrowing (
  borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
  borrower_id INT NOT NULL,
  asset_id INT NOT NULL,
  approver_id INT,
  status ENUM('pending', 'approved', 'borrowed', 'returned', 'rejected', 'cancelled') DEFAULT 'pending',
  borrow_date DATE NOT NULL,
  return_date DATE,
  returned_at DATETIME,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (borrower_id) REFERENCES users(uid),
  FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
  FOREIGN KEY (approver_id) REFERENCES users(uid)
);

-- Insert sample categories
INSERT INTO category (name, image, is_active) VALUES
('Laptops', 'laptop.png', 1),
('Projectors', 'projector.png', 1),
('Cameras', 'camera.png', 1),
('Audio Equipment', 'audio.png', 1);

-- Insert sample assets
INSERT INTO asset (asset_code, asset_name, category_id, status) VALUES
('LAP-001', 'Dell XPS 15', 1, 'available'),
('LAP-002', 'MacBook Pro 16"', 1, 'available'),
('PRJ-001', 'Epson EB-X05', 2, 'available'),
('PRJ-002', 'BenQ MH535A', 2, 'available'),
('CAM-001', 'Canon EOS R6', 3, 'available'),
('AUD-001', 'Shure SM58 Microphone', 4, 'available');

-- Insert sample admin user (password: admin123)
-- Note: This is a placeholder, will be replaced with properly hashed password
INSERT INTO users (email, password, first_name, last_name, username, role) VALUES
('admin@example.com', '$argon2id$v=19$m=19456,t=2,p=1$placeholder', 'Admin', 'User', 'admin', 'admin');

SELECT 'Database setup completed successfully!' AS message;
