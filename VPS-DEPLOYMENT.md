# 🚀 CASHPONG VPS DEPLOYMENT GUIDE (HOSTINGER)

## 📋 Prerequisites on VPS:
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 18+
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2 globally
sudo npm install -g pm2

# Install Git
sudo apt install git -y
```

## 🔧 Deployment Steps:

### 1. Clone your repository on VPS:
```bash
cd /var/www  # or your preferred directory
sudo git clone https://github.com/Aestheticsgods/cashpong-game.git
cd cashpong-game
sudo chown -R $USER:$USER /var/www/cashpong-game
```

### 2. Install dependencies:
```bash
npm install
```

### 3. Create logs directory:
```bash
mkdir logs
```

### 4. Update your domain in configuration:
All configuration files have been updated with cashpong.io domain.
Your VPS IP: 72.60.70.13
Your domain: cashpong.io

If you need to make changes, edit:
- `.env.production`
- `server.js` (CORS origin settings)
- `server-multiplayer.js` (CORS origin settings)

### 5. Start with PM2:
```bash
# Start main server on port 3000
pm2 start ecosystem.config.json --only cashpong-main

# Start multiplayer server on port 3001 (optional)
pm2 start ecosystem.config.json --only cashpong-multiplayer

# Save PM2 configuration
pm2 save
pm2 startup
```

### 6. Configure Nginx (Reverse Proxy):
Create `/etc/nginx/sites-available/cashpong`:
```nginx
server {
    listen 80;
    server_name cashpong.io www.cashpong.io;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    location /socket.io/ {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/cashpong /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 7. Configure Firewall:
```bash
sudo ufw allow 22      # SSH
sudo ufw allow 80      # HTTP
sudo ufw allow 443     # HTTPS
sudo ufw allow 3000    # Node.js main
sudo ufw allow 3001    # Node.js multiplayer
sudo ufw enable
```

### 8. SSL Certificate (Optional):
```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d cashpong.io -d www.cashpong.io
```

## 📊 Monitoring:
```bash
# Check PM2 status
pm2 status

# View logs
pm2 logs cashpong-main
pm2 logs cashpong-multiplayer

# Restart if needed
pm2 restart cashpong-main
pm2 restart cashpong-multiplayer
```

## 🌐 Access your game:
- **Production URL:** `https://cashpong.io`
- **Direct IP:** `http://72.60.70.13:3000`
- **Testing URL:** `http://cashpong.io:3000`

## 🔧 Update deployment:
```bash
cd /var/www/cashpong-game
git pull origin main
npm install  # if package.json changed
pm2 restart all
```

## 🚨 Troubleshooting:
- Check logs: `pm2 logs`
- Check port usage: `netstat -tulpn | grep :3000`
- Check PM2 processes: `pm2 status`
- Restart services: `pm2 restart all`
