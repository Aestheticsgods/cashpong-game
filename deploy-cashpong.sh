#!/bin/bash

# 🚀 CASHPONG.IO DEPLOYMENT SCRIPT
# Run this on your VPS (72.60.70.13) after cloning the repository

echo "🚀 Starting CashPong.io deployment..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Node.js if not installed
if ! command -v node &> /dev/null; then
    echo "📥 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install PM2 if not installed
if ! command -v pm2 &> /dev/null; then
    echo "📥 Installing PM2..."
    sudo npm install -g pm2
fi

# Install dependencies
echo "📦 Installing project dependencies..."
npm install

# Create logs directory
echo "📁 Creating logs directory..."
mkdir -p logs

# Stop any existing PM2 processes
echo "🛑 Stopping existing processes..."
pm2 delete cashpong-main 2>/dev/null || true
pm2 delete cashpong-multiplayer 2>/dev/null || true

# Start the main server
echo "🚀 Starting CashPong main server..."
pm2 start ecosystem.config.json --only cashpong-main

# Save PM2 configuration
echo "💾 Saving PM2 configuration..."
pm2 save

# Setup PM2 startup script
echo "⚙️ Setting up PM2 startup..."
pm2 startup

echo "✅ CashPong.io deployment completed!"
echo ""
echo "🌐 Your game is now accessible at:"
echo "   - Direct IP: http://72.60.70.13:3000"
echo "   - Domain: http://cashpong.io:3000 (after DNS propagation)"
echo ""
echo "📊 Check status with: pm2 status"
echo "📋 View logs with: pm2 logs cashpong-main"
echo ""
echo "🔧 Next steps:"
echo "   1. Configure your domain DNS to point to 72.60.70.13"
echo "   2. Setup Nginx reverse proxy (see VPS-DEPLOYMENT.md)"
echo "   3. Install SSL certificate for HTTPS"
