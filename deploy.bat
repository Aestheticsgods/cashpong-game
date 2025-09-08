@echo off
echo Deploying Socket.IO fixes to VPS...
ssh root@cashpong.io "cd /root/cashpong-game && echo 'Pulling latest changes...' && git pull origin main && echo 'Restarting server...' && pm2 restart cashpong-main && echo 'Deployment complete!'"
echo.
echo Please test the game now - both players should see the ball and paddles!
pause
