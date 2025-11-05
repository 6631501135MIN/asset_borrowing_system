# 🎯 THUNDER CLIENT TESTING GUIDE

## Step-by-Step Instructions for Testing /api/register

---

## Method 1: Using Pre-Made Collection (Recommended)

### Step 1: Open Thunder Client
1. Look at the **left sidebar** in VS Code
2. Find the **Thunder Client icon** (looks like a lightning bolt ⚡)
3. Click on it

### Step 2: Navigate to Collections
1. Click on the **"Collections"** tab (second tab)
2. You should see: **"Student Registration API"**
3. Click the arrow to expand it

### Step 3: Run Tests
You'll see 4 test requests:

#### ✅ Test 1: "Register - Success"
- Click on it
- Click **"Send"** button
- ✅ **Expected:** Status 200, Response shows success message

#### ✅ Test 2: "Register - Minimal Fields Only"  
- Click on it
- Click **"Send"** button
- ✅ **Expected:** Status 200, Registration successful

#### ❌ Test 3: "Register - Missing Required Fields"
- Click on it
- Click **"Send"** button
- ❌ **Expected:** Status 400, Error message about required fields

#### ❌ Test 4: "Register - Duplicate Username/Email"
- **Note:** Run Test 1 first, then run this
- Click **"Send"** button
- ❌ **Expected:** Status 400, "Username or email already exists"

---

## Method 2: Create New Request Manually

### Step 1: Create New Request
1. Open Thunder Client
2. Click **"Activity"** tab (first tab)
3. Click **"New Request"** button

### Step 2: Configure Request
1. **Method:** Select `POST` from dropdown
2. **URL:** Type `http://localhost:3000/api/register`

### Step 3: Add Headers
1. Click **"Headers"** tab
2. Add header:
   - Name: `Content-Type`
   - Value: `application/json`

### Step 4: Add Body
1. Click **"Body"** tab
2. Select **"JSON"** from dropdown
3. Paste this:

```json
{
  "email": "newuser@example.com",
  "password": "SecurePass123!",
  "first_name": "New",
  "last_name": "User",
  "ph_num": "+9876543210",
  "username": "newuser"
}
```

### Step 5: Send Request
1. Click the **"Send"** button (big button at top right)
2. Check the response at the bottom

---

## 📊 What to Look For

### ✅ Success Response (Status: 200 OK)
```json
{
  "message": "Registration successful",
  "uid": 3
}
```

**What this means:**
- ✅ User was created successfully
- ✅ The user ID is 3
- ✅ User can now login

---

### ❌ Error Responses

#### Missing Required Fields (Status: 400)
```
email, password, first_name, username are required
```

**What this means:**
- You forgot to include required fields in the request

#### Duplicate User (Status: 400)
```
Username or email already exists
```

**What this means:**
- This username or email is already registered
- Try a different username/email

---

## 🧪 Additional Tests You Can Try

### Test 1: Register with Minimal Data
```json
{
  "email": "simple@test.com",
  "password": "Pass123!",
  "first_name": "Simple",
  "username": "simpleuser"
}
```
**Expected:** ✅ Success (last_name and ph_num are optional)

---

### Test 2: Try to Register Without Email
```json
{
  "password": "Pass123!",
  "first_name": "Test",
  "username": "testuser"
}
```
**Expected:** ❌ Error - "email, password, first_name, username are required"

---

### Test 3: Try Duplicate Username
First, register a user, then try to register again with the same username.

**First Request:**
```json
{
  "email": "user1@test.com",
  "password": "Pass123!",
  "first_name": "User",
  "username": "sameuser"
}
```

**Second Request:**
```json
{
  "email": "user2@test.com",
  "password": "Pass123!",
  "first_name": "User",
  "username": "sameuser"
}
```
**Expected:** ❌ Error - "Username or email already exists"

---

## 🔄 Complete Registration → Login Flow

### Step 1: Register
```
POST http://localhost:3000/api/register

Body:
{
  "email": "flowtest@example.com",
  "password": "FlowTest123!",
  "first_name": "Flow",
  "username": "flowtest"
}
```

### Step 2: Login (use the same credentials)
```
POST http://localhost:3000/api/login

Body:
{
  "username": "flowtest",
  "password": "FlowTest123!"
}
```

### Step 3: Verify Response
You should get back user information:
```json
{
  "uid": 4,
  "username": "flowtest",
  "role": "student",
  "first_name": "Flow",
  "last_name": null,
  "email": "flowtest@example.com"
}
```

---

## 📸 Screenshots Guide

### Where to Find Thunder Client
```
VS Code Sidebar → ⚡ Thunder Client Icon
```

### Thunder Client Tabs
```
Activity     → Your test requests
Collections  → Pre-made test collections (OUR TESTS ARE HERE!)
Env          → Environment variables
```

### Request Sections
```
Top Bar      → Method (POST) + URL
Headers      → Content-Type: application/json
Body         → Your JSON data
Response     → Bottom panel shows results
```

---

## ⚡ Quick Tips

1. **Always check the URL:** Make sure it's `http://localhost:3000/api/register`
2. **Select JSON:** In Body tab, choose JSON from the dropdown
3. **Valid JSON:** Make sure your JSON is properly formatted (no trailing commas)
4. **Unique usernames:** Each registration needs a unique username and email
5. **Check server:** Make sure `node app.js` is running in terminal

---

## 🐛 Troubleshooting

### Problem: "Failed to fetch" or connection error
**Solution:** 
```bash
# Check if server is running
node app.js
```

### Problem: "Username or email already exists"
**Solution:** Change the username or email to something unique
```json
{
  "username": "uniqueuser123",
  "email": "unique123@test.com"
}
```

### Problem: "email, password, first_name, username are required"
**Solution:** Make sure all 4 required fields are in your request

### Problem: Can't find Thunder Client
**Solution:**
1. Go to Extensions (Cmd+Shift+X)
2. Search for "Thunder Client"
3. Install it
4. Restart VS Code

---

## ✨ You're Ready!

Your server is running at: **http://localhost:3000** ✅
Your database is set up: **asset_management** ✅
Your tests are ready: **Thunder Client Collections** ✅

**Now go ahead and test the /api/register endpoint!** 🚀
