# API Endpoint Quick Reference

## Base URL
```
http://localhost:3000
```

---

## 🔐 Authentication Endpoints

### 1. Register New User (Student)
**Endpoint:** `POST /api/register`

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "YourPassword123!",
  "first_name": "First",
  "last_name": "Last",
  "ph_num": "+1234567890",
  "username": "yourusername"
}
```

**Success Response (200):**
```json
{
  "message": "Registration successful",
  "uid": 2
}
```

**Error Responses:**
- `400` - Missing required fields
- `400` - Username or email already exists

---

### 2. Login
**Endpoint:** `POST /api/login`

**Request Body:**
```json
{
  "username": "yourusername",
  "password": "YourPassword123!"
}
```

**Success Response (200):**
```json
{
  "uid": 2,
  "username": "yourusername",
  "role": "student",
  "first_name": "First",
  "last_name": "Last",
  "email": "user@example.com"
}
```

---

## 📦 Asset Endpoints

### 3. Get All Available Assets
**Endpoint:** `GET /api/student/assets`

**Success Response (200):**
```json
[
  {
    "asset_id": 1,
    "asset_code": "LAP-001",
    "asset_name": "Dell XPS 15",
    "status": "available",
    "category_name": "Laptops",
    "category_image": "laptop.png"
  }
]
```

---

### 4. Get Assets by Category
**Endpoint:** `GET /api/student/assets/category/:categoryId`

**Example:** `GET /api/student/assets/category/1`

---

### 5. Get All Categories
**Endpoint:** `GET /api/student/categories`

**Success Response (200):**
```json
[
  {
    "category_id": 1,
    "name": "Laptops",
    "image": "laptop.png"
  }
]
```

---

## 📝 Borrowing Endpoints

### 6. Request to Borrow Asset
**Endpoint:** `POST /api/student/borrow`

**Request Body:**
```json
{
  "borrower_id": 2,
  "asset_id": 1,
  "borrow_date": "2025-11-10",
  "return_date": "2025-11-15"
}
```

**Success Response (200):**
```json
{
  "message": "Borrow request submitted",
  "borrowing_id": 1
}
```

---

### 7. Get Borrowing History
**Endpoint:** `GET /api/student/history/:uid`

**Example:** `GET /api/student/history/2`

---

### 8. Get Pending/Approved Requests
**Endpoint:** `GET /api/student/requests/:uid`

**Example:** `GET /api/student/requests/2`

---

### 9. Cancel Pending Request
**Endpoint:** `PUT /api/student/cancel/:borrowingId`

**Example:** `PUT /api/student/cancel/1`

**Request Body:**
```json
{
  "borrower_id": 2
}
```

---

## 🛠️ Utility Endpoints

### 10. Generate Password Hash
**Endpoint:** `GET /api/password/:raw`

**Example:** `GET /api/password/mypassword123`

**Response:**
```
$argon2id$v=19$m=19456,t=2,p=1$...hashed_password...
```

---

## 📋 Test Scenarios for Thunder Client

### Scenario 1: Complete User Registration Flow
1. Register: `POST /api/register` (get uid)
2. Login: `POST /api/login` (verify credentials)
3. Get Assets: `GET /api/student/assets`

### Scenario 2: Asset Borrowing Flow
1. Login: `POST /api/login` (get uid)
2. Get Assets: `GET /api/student/assets` (get asset_id)
3. Borrow: `POST /api/student/borrow`
4. Check Requests: `GET /api/student/requests/:uid`

### Scenario 3: Error Handling
1. Register with missing fields (expect 400)
2. Register duplicate username (expect 400)
3. Login with wrong password (expect 401)

---

## 🎨 Status Codes

- `200` - Success
- `400` - Bad Request (validation error)
- `401` - Unauthorized (wrong credentials)
- `403` - Forbidden (not authorized)
- `404` - Not Found
- `500` - Internal Server Error

---

## 🗂️ Database Info

**Database Name:** `asset_management`

**Default Credentials:**
- Username: `admin`
- Password: `admin123`
- Role: `admin`

**Sample Assets Available:**
- LAP-001: Dell XPS 15
- LAP-002: MacBook Pro 16"
- PRJ-001: Epson EB-X05
- PRJ-002: BenQ MH535A
- CAM-001: Canon EOS R6
- AUD-001: Shure SM58 Microphone
