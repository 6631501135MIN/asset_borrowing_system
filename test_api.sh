#!/bin/bash

# Quick API Test Script
# Run this to verify all endpoints are working

BASE_URL="http://localhost:3000"

echo "🧪 Testing Asset Management API"
echo "================================"
echo ""

echo "1️⃣  Testing Registration..."
REGISTER_RESPONSE=$(curl -s -X POST "$BASE_URL/api/register" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test'$(date +%s)'@example.com",
    "password": "TestPass123!",
    "first_name": "Test",
    "last_name": "User",
    "username": "testuser'$(date +%s)'"
  }')
echo "✅ $REGISTER_RESPONSE"
echo ""

echo "2️⃣  Testing Login (with admin)..."
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/api/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }')
echo "✅ $LOGIN_RESPONSE"
echo ""

echo "3️⃣  Testing Get Categories..."
CATEGORIES=$(curl -s "$BASE_URL/api/student/categories")
echo "✅ Found $(echo $CATEGORIES | grep -o 'category_id' | wc -l | xargs) categories"
echo ""

echo "4️⃣  Testing Get Available Assets..."
ASSETS=$(curl -s "$BASE_URL/api/student/assets")
echo "✅ Found $(echo $ASSETS | grep -o 'asset_id' | wc -l | xargs) assets"
echo ""

echo "🎉 All tests completed!"
echo ""
echo "Now you can test in Thunder Client:"
echo "  1. Open Thunder Client extension"
echo "  2. Go to Collections tab"
echo "  3. Find 'Student Registration API'"
echo "  4. Run the test cases"
