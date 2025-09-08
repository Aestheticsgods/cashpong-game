# 🌐 DNS CONFIGURATION FOR CASHPONG.IO

## 📋 Current Setup:
- **Domain:** cashpong.io
- **VPS IP:** 72.60.70.13
- **Server Port:** 3000

## 🔧 DNS Records to Add:

### A Records:
```
Type: A
Name: @
Value: 72.60.70.13
TTL: 300 (or default)

Type: A  
Name: www
Value: 72.60.70.13
TTL: 300 (or default)
```

### CNAME Records (Optional):
```
Type: CNAME
Name: game
Value: cashpong.io
TTL: 300

Type: CNAME
Name: play
Value: cashpong.io
TTL: 300
```

## 🌍 Hostinger DNS Setup:
1. Login to your Hostinger control panel
2. Go to "DNS Zone" or "DNS Management"
3. Add the A records above
4. Wait 5-30 minutes for DNS propagation

## ✅ Testing DNS:
```bash
# Check if DNS is working
nslookup cashpong.io
dig cashpong.io

# Expected result: 72.60.70.13
```

## 🚀 Access Points:
After DNS propagation, your game will be accessible at:
- `http://cashpong.io:3000` (direct port access)
- `http://72.60.70.13:3000` (IP access - always works)
- `https://cashpong.io` (after Nginx + SSL setup)

## 🔒 Next Steps:
1. Wait for DNS propagation (5-30 minutes)
2. Setup Nginx reverse proxy (removes :3000 from URL)
3. Install SSL certificate for HTTPS
4. Test the game at cashpong.io
