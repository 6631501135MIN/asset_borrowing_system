// file: server/db.js
require('dotenv').config();
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'asset_management'
});

connection.connect((err) => {
  if (err) {
    console.error('❌ Error connecting to database:', err.message);
    console.error('Please run: node setup.js');
    process.exit(1);
  }
  console.log(`✅ Connected to MySQL database: ${process.env.DB_NAME}`);
});

module.exports = connection;
