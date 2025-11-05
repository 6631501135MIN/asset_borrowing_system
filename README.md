# Asset Management System - API Server

A complete REST API for managing asset borrowing with user authentication and role-based access.

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Setup Database
```bash
node setup.js
```

This will:
- Create `asset_management` database
- Create all required tables (users, category, asset, borrowing)
- Insert sample categories and assets
- Create admin user (username: `admin`, password: `admin123`)

### 3. Start Server
```bash
node app.js
```

Server runs on: **http://localhost:3000**

---

## 📊 Database Schema

### Users Table
- `uid` - Primary key
- `email` - Unique email
- `username` - Unique username
- `password` - Hashed password (argon2)
- `first_name`, `last_name`, `ph_num`
- `profile_img` - Profile image filename
- `role` - 'student' or 'admin'

### Category Table
- `category_id` - Primary key
- `name` - Category name
- `image` - Category image
- `is_active` - Active status

### Asset Table
- `asset_id` - Primary key
- `asset_code` - Unique code
- `asset_name` - Asset name
- `category_id` - Foreign key
- `status` - available/pending/borrowed/maintenance

### Borrowing Table
- `borrowing_id` - Primary key
- `borrower_id` - Foreign key to users
- `asset_id` - Foreign key to assets
- `approver_id` - Foreign key to users (admin)
- `status` - pending/approved/borrowed/returned/rejected/cancelled
- `borrow_date`, `return_date`, `returned_at`

---

## 📡 API Endpoints

### Authentication

#### Register (Student)
```
POST /api/register
```
**Body:**
```json
{
  "email": "john@example.com",
  "password": "SecurePass123!",
  "first_name": "John",
  "last_name": "Doe",
  "ph_num": "+1234567890",
  "username": "johndoe"
}
```
**Response:**
```json
{
  "message": "Registration successful",
  "uid": 2
}
```

#### Login
```
POST /api/login
```
**Body:**
```json
{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```
**Response:**
```json
{
  "uid": 2,
  "username": "johndoe",
  "role": "student",
  "first_name": "John",
  "last_name": "Doe",
  "email": "john@example.com"
}
```

---

### Student APIs

#### Get All Available Assets
```
GET /api/student/assets
```

#### Get Assets by Category
```
GET /api/student/assets/category/:categoryId
```

#### Get All Active Categories
```
GET /api/student/categories
```

#### Request to Borrow Asset
```
POST /api/student/borrow
```
**Body:**
```json
{
  "borrower_id": 2,
  "asset_id": 1,
  "borrow_date": "2025-11-10",
  "return_date": "2025-11-15"
}
```

#### Get Borrowing History
```
GET /api/student/history/:uid
```

#### Get Pending/Approved Requests
```
GET /api/student/requests/:uid
```

#### Cancel Pending Request
```
PUT /api/student/cancel/:borrowingId
```
**Body:**
```json
{
  "borrower_id": 2
}
```

---

### Utility APIs

#### Generate Password Hash
```
GET /api/password/:raw
```
Example: `GET /api/password/mypassword123`

---

## 🧪 Testing with Thunder Client

Thunder Client test collection is included in `thunder-tests/` folder:

### Test Cases:
1. ✅ **Register - Success** (all fields)
2. ✅ **Register - Minimal** (required fields only)
3. ❌ **Register - Missing Fields**
4. ❌ **Register - Duplicate User**

### How to Test:
1. Open Thunder Client in VS Code
2. Go to Collections tab
3. Find "Student Registration API" collection
4. Run tests individually or all at once

---

## 🗄️ Sample Data Included

### Categories:
- Laptops
- Projectors
- Cameras
- Audio Equipment

### Assets:
- Dell XPS 15 (LAP-001)
- MacBook Pro 16" (LAP-002)
- Epson EB-X05 (PRJ-001)
- BenQ MH535A (PRJ-002)
- Canon EOS R6 (CAM-001)
- Shure SM58 Microphone (AUD-001)

### Default Admin User:
- Username: `admin`
- Password: `admin123`
- Email: `admin@example.com`

---

## 🔧 Configuration

Edit `db.js` to change database credentials:
```javascript
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'asset_management'
});
```

---

## 📦 Dependencies

- **express** ^5.1.0 - Web framework
- **mysql2** ^3.15.3 - MySQL driver
- **@node-rs/argon2** ^2.0.2 - Password hashing

---

## 🛠️ Troubleshooting

### Database Connection Error
```bash
# Re-run setup
node setup.js
```

### Port 3000 Already in Use
```bash
# Kill existing process
pkill -f "node app.js"
```

### MySQL Not Running
```bash
# Start MySQL service (macOS)
brew services start mysql
```

---

## 📝 Project Structure

```
server_asset/
├── app.js                 # Main application
├── db.js                  # Database connection
├── setup.js               # Database setup script
├── setup_database.sql     # SQL schema
├── package.json           # Dependencies
├── README.md              # This file
└── thunder-tests/         # API test collection
    ├── thunderActivity.json
    ├── thunderclient.json
    └── thunderCollection.json
```

---

## ✅ API Testing Examples

### Using cURL:

**Register:**
```bash
curl -X POST http://localhost:3000/api/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123!",
    "first_name": "Test",
    "username": "testuser"
  }'
```

**Login:**
```bash
curl -X POST http://localhost:3000/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "Test123!"
  }'
```

**Get Available Assets:**
```bash
curl http://localhost:3000/api/student/assets
```

---

## 🎯 Next Steps

1. ✅ Database setup complete
2. ✅ Server running
3. ✅ API endpoints ready
4. ✅ Test collection created
5. 🔜 Test `/api/register` in Thunder Client!

---

**Created:** November 5, 2025  
**Version:** 1.0.0
