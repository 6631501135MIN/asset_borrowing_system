// Setup script to create database and tables
require('dotenv').config();
const mysql = require('mysql2');
const argon2 = require('@node-rs/argon2');

// First connect without specifying database
const connection = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  multipleStatements: true
});

console.log('🔄 Setting up database...\n');

const DB_NAME = process.env.DB_NAME || 'asset_management';

const setupSQL = `
-- Create database
DROP DATABASE IF EXISTS ${DB_NAME};
CREATE DATABASE ${DB_NAME};
USE ${DB_NAME};

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
`;

connection.connect((err) => {
  if (err) {
    console.error('❌ Error connecting to MySQL:', err.message);
    console.error('\n💡 Make sure MySQL is running and check .env file for correct credentials.');
    process.exit(1);
  }

  console.log('✅ Connected to MySQL\n');

  connection.query(setupSQL, (err, results) => {
    if (err) {
      console.error('❌ Error setting up database:', err.message);
      connection.end();
      process.exit(1);
    }

    console.log(`✅ Database created: ${DB_NAME}`);
    console.log('✅ Tables created: users, category, asset, borrowing');
    console.log('✅ Sample data inserted\n');

    // Now create admin user with hashed password
    const adminPassword = argon2.hashSync('admin123');
    const insertAdminSQL = `
      USE ${DB_NAME};
      INSERT INTO users (email, password, first_name, last_name, username, role) VALUES
      ('admin@example.com', ?, 'Admin', 'User', 'admin', 'admin');
    `;

    connection.query(insertAdminSQL, [adminPassword], (err2) => {
      if (err2) {
        console.error('⚠️  Warning: Could not create admin user:', err2.message);
      } else {
        console.log('✅ Admin user created:');
        console.log('   Username: admin');
        console.log('   Password: admin123');
      }

      console.log('\n🎉 Database setup completed successfully!');
      console.log('📝 You can now run: node app.js\n');
      connection.end();
    });
  });
});
