#!/bin/bash

# Script to update HOST IP address in .env file

echo "🔧 Current Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cat .env | grep "^HOST="
echo ""

echo "📡 Available Network Interfaces:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. localhost (127.0.0.1)"
echo "2. $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1) (Your Local IP)"
echo "3. 0.0.0.0 (All interfaces)"
echo "4. Custom IP"
echo ""

read -p "Select option (1-4): " choice

case $choice in
  1)
    NEW_HOST="localhost"
    ;;
  2)
    NEW_HOST=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
    ;;
  3)
    NEW_HOST="0.0.0.0"
    ;;
  4)
    read -p "Enter custom IP address: " NEW_HOST
    ;;
  *)
    echo "❌ Invalid option"
    exit 1
    ;;
esac

# Update .env file
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/^HOST=.*/HOST=$NEW_HOST/" .env
else
  # Linux
  sed -i "s/^HOST=.*/HOST=$NEW_HOST/" .env
fi

# Update Thunder Client environment
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s|\"value\": \"http://[^:]*:3000\"|\"value\": \"http://$NEW_HOST:3000\"|g" thunder-tests/thunderEnvironment.json
  sed -i '' "s|\"value\": \"[^\"]*\",.*HOST|\"value\": \"$NEW_HOST\",|g" thunder-tests/thunderEnvironment.json
else
  sed -i "s|\"value\": \"http://[^:]*:3000\"|\"value\": \"http://$NEW_HOST:3000\"|g" thunder-tests/thunderEnvironment.json
  sed -i "s|\"value\": \"[^\"]*\",.*HOST|\"value\": \"$NEW_HOST\",|g" thunder-tests/thunderEnvironment.json
fi

echo ""
echo "✅ Configuration Updated!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "HOST=$NEW_HOST"
echo ""
echo "🔄 Restart the server to apply changes:"
echo "   npm start"
echo ""
echo "📡 API will be available at:"
echo "   http://$NEW_HOST:3000/api"
