# 🌐 Environment Configuration Guide

## 📁 .env File Configuration

The project now uses environment variables for easy configuration. You can change the host, port, and database settings without modifying the code!

---

## 🔧 Current Configuration

Your current `.env` file:
```env
HOST=192.168.1.173
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=asset_management
NODE_ENV=development
```

**Current API URL:** `http://192.168.1.173:3000/api`

---

## 🔄 How to Change the HOST

### Method 1: Using the Helper Script (Easiest)

Run the interactive script:
```bash
./change_host.sh
```

It will show you options:
1. **localhost** - For local testing only
2. **192.168.1.173** - Your current local IP (accessible from other devices)
3. **0.0.0.0** - Listen on all network interfaces
4. **Custom IP** - Enter any IP address

### Method 2: Manually Edit .env File

1. Open `.env` file
2. Change the `HOST` value:
```env
# For localhost only
HOST=localhost

# For your local network IP
HOST=192.168.1.173

# For all interfaces
HOST=0.0.0.0

# For custom IP
HOST=192.168.1.100
```
3. Save the file
4. Restart the server: `npm start`

---

## 📱 Access from Different Devices

### From the Same Computer
```
http://localhost:3000/api
```

### From Phone/Tablet on Same WiFi
```
http://192.168.1.173:3000/api
```

### From Another Computer on Same Network
```
http://192.168.1.173:3000/api
```

**Make sure:**
- ✅ Devices are on the same WiFi network
- ✅ Firewall allows port 3000
- ✅ Server is running with the correct HOST setting

---

## 🎯 Common HOST Settings

| HOST Value | Use Case | Accessible From |
|------------|----------|-----------------|
| `localhost` | Local development only | Same computer only |
| `127.0.0.1` | Local development only | Same computer only |
| `192.168.x.x` | Your local IP | Same network devices |
| `0.0.0.0` | All interfaces | Anywhere (if firewall allows) |

---

## 🔐 Database Configuration

You can also change database settings in `.env`:

```env
DB_HOST=localhost          # MySQL server host
DB_USER=root              # MySQL username
DB_PASSWORD=              # MySQL password (empty for no password)
DB_NAME=asset_management  # Database name
```

---

## 📝 Environment Variables Explained

### Server Settings
- `HOST` - IP address where server listens (default: localhost)
- `PORT` - Port number (default: 3000)
- `NODE_ENV` - Environment (development/production)

### Database Settings
- `DB_HOST` - MySQL server address
- `DB_USER` - MySQL username
- `DB_PASSWORD` - MySQL password
- `DB_NAME` - Database name

---

## 🧪 Thunder Client Configuration

Thunder Client now uses environment variables!

**Two environments are pre-configured:**

### 1. Local Development (Default)
- BASE_URL: `http://192.168.1.173:3000`
- For testing from any device on your network

### 2. Localhost
- BASE_URL: `http://localhost:3000`
- For testing on the same computer only

**To switch environments in Thunder Client:**
1. Click on "Env" dropdown (top of Thunder Client)
2. Select "Local Development" or "Localhost"
3. Run your tests

---

## 🚀 Quick Start Commands

### Start with current .env settings
```bash
npm start
```

### Change host interactively
```bash
./change_host.sh
```

### Reset database
```bash
npm run setup
```

### Test API
```bash
curl http://192.168.1.173:3000/api/student/assets
```

---

## 🔍 Find Your Local IP Address

### macOS/Linux
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

### Windows (Command Prompt)
```cmd
ipconfig
```

Look for "IPv4 Address" under your active network adapter.

---

## 📊 Testing After Changing HOST

### 1. Restart Server
```bash
npm start
```

### 2. Check Server Output
You should see:
```
🚀 Server is running on http://YOUR_NEW_HOST:3000
📡 API Base URL: http://YOUR_NEW_HOST:3000/api
```

### 3. Test Endpoints
```bash
# Replace YOUR_HOST with your HOST value
curl http://YOUR_HOST:3000/api/student/assets

# Example with IP
curl http://192.168.1.173:3000/api/student/assets

# Example with localhost
curl http://localhost:3000/api/student/assets
```

### 4. Update Thunder Client
Thunder Client environment variables are automatically updated when you run `./change_host.sh`

---

## ⚙️ Advanced Configuration

### Multiple Environment Files

Create different .env files for different scenarios:

**.env.local** (localhost)
```env
HOST=localhost
PORT=3000
```

**.env.network** (network access)
```env
HOST=192.168.1.173
PORT=3000
```

**.env.production** (production)
```env
HOST=0.0.0.0
PORT=8080
```

**Load specific env file:**
```bash
# Copy the desired env file
cp .env.local .env
npm start
```

---

## 🐛 Troubleshooting

### Can't access from phone/tablet?

1. **Check HOST setting:**
   ```bash
   cat .env | grep HOST
   ```
   Should show your local IP, not localhost

2. **Check firewall:**
   - macOS: System Preferences → Security & Privacy → Firewall
   - Allow Node.js or port 3000

3. **Verify same network:**
   - Phone and computer must be on same WiFi
   - Check phone's WiFi settings

4. **Test connectivity:**
   ```bash
   # From another device, ping your server
   ping 192.168.1.173
   ```

### Server won't start?

1. **Check if port is in use:**
   ```bash
   lsof -i :3000
   ```

2. **Kill existing process:**
   ```bash
   pkill -f "node app.js"
   ```

3. **Change port in .env:**
   ```env
   PORT=3001
   ```

### Database connection error?

1. **Check database credentials in .env**
2. **Verify MySQL is running:**
   ```bash
   brew services list | grep mysql
   ```

3. **Re-run setup:**
   ```bash
   npm run setup
   ```

---

## 📋 Quick Reference

**Change to localhost:**
```bash
echo "HOST=localhost" > .env.temp && 
cat .env | grep -v "^HOST=" >> .env.temp && 
mv .env.temp .env && 
npm start
```

**Change to local IP:**
```bash
LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
sed -i '' "s/^HOST=.*/HOST=$LOCAL_IP/" .env
npm start
```

**Change to all interfaces:**
```bash
sed -i '' "s/^HOST=.*/HOST=0.0.0.0/" .env
npm start
```

---

## ✅ Best Practices

1. **Never commit .env to git** - It's already in `.gitignore`
2. **Use .env.example as template** - Share this with your team
3. **Document custom variables** - Add comments in .env
4. **Use different hosts for different purposes:**
   - Development: localhost
   - Testing on phone: local IP
   - Production: 0.0.0.0 or specific IP

---

**Your current setup:**
- ✅ Server: http://192.168.1.173:3000
- ✅ API: http://192.168.1.173:3000/api
- ✅ Database: asset_management
- ✅ Thunder Client: Configured with environment variables

**Ready to test from any device on your network!** 📱💻🖥️
