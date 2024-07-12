#!/bin/bash

LICENSE_FILE="$HOME/.license"

# ANSI escape sequences for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RESET='\033[0m'  # Reset text color to default

# Fungsi untuk meminta lisensi dari pengguna
request_license() {
    echo "Masukkan lisensi Anda:"
    read -r LICENSE_KEY
    echo "$LICENSE_KEY" > "$LICENSE_FILE"
}

# Fungsi untuk memeriksa lisensi
check_license() {
    LICENSE_KEY=$(cat "$LICENSE_FILE")
    if [ "$LICENSE_KEY" == "RAIN" ]; then
        return 0
    else
        echo "Lisensi tidak valid."
        return 1
    fi
}

# Fungsi untuk menampilkan pesan setelah lisensi valid
display_message() {
    clear
    echo ""
    echo ""
    echo ""
    echo -e "${RED}"
    echo "          -o          o-            ____      _    ___ _   _ __  __ ____"
    echo "          +hydNNNNdyh+             |  _ \\    / \\  |_ _| \\ | |  \\/  |/ ___|"
    echo "        +mMMMMMMMMMMMMm+           | |_) |  / _ \\  | ||  \\| | |\\/| | |"
    echo "      \`dMMm:NMMMMMMN:mMMd\`         |  _ <  / ___ \\ | || |\\  | |  | | |___"
    echo "      hMMMMMMMMMMMMMMMMMMh         |_| \\_\\/_/   \\_\\___|_| \\_|_|  |_|\\____|"
    echo "  ..  yyyyyyyyyyyyyyyyyyyy  .."
    echo ".mMMm\`MMMMMMMMMMMMMMMMMMMM\`mMMm."
    echo ":MMMM-MMMMMMMMMMMMMMMMMMMM-MMMM:"
    echo ":MMMM-MMMMMMMMMMMMMMMMMMMM-MMMM:"
    echo ":MMMM-MMMMMMMMMMMMMMMMMMMM-MMMM:"
    echo ":MMMM-MMMMMMMMMMMMMMMMMMMM-MMMM:"
    echo "-MMMM-MMMMMMMMMMMMMMMMMMMM-MMMM-"
    echo " +yy+ MMMMMMMMMMMMMMMMMMMM +yy+"
    echo "      mMMMMMMMMMMMMMMMMMMm"
    echo "      \`/++MMMMh++hMMMM++/\`"
    echo "          MMMMo  oMMMM"
    echo "          MMMMo  oMMMM"
    echo "          oNMm-  -mMNs"
    echo -e "${RESET}"
    echo ""
    echo ""
    echo -e "${BLUE}                    WHATSAPP : 085263390832${RESET}"
    echo -e "${YELLOW}                    YOUTUBE  : RAINMC${RESET}"
    echo ""
}

# Fungsi instalasi perangkat lunak
install_software() {
    echo -e "LICENSE ANDA BENAR, SILAKAN MASUKAN ULANG"
}

# Fungsi untuk animasi teks berkedip satu per satu
animate_text() {
    local text="$1"
    local delay="${2:-0.1}"

    for (( i = 0; i < ${#text}; i++ )); do
        echo -en "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${RESET}"
}

# Fungsi untuk menangani pilihan "FIX YARN"
fix_yarn() {
    echo "Anda memilih untuk memperbaiki YARN."
    echo "Menjalankan perintah perbaikan YARN..."
    echo "KAMU HARUS MEMILIKI PANEL PTERODACTYL TERLEBIH DAHULU! APAKAH ANDA MEMPUNYAINYA? (YES/NO)"
    read -r HAS_PTERODACTYL

    if [ "$HAS_PTERODACTYL" == "YES" ] || [ "$HAS_PTERODACTYL" == "yes" ]; then
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt update
        sudo apt install -y nodejs
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn build:production
        echo "Perbaikan YARN selesai."
    elif [ "$HAS_PTERODACTYL" == "NO" ] || [ "$HAS_PTERODACTYL" == "no" ]; then
        echo "Instalasi tema Enigma dibatalkan karena Anda tidak memiliki panel Pterodactyl."
        exit 1
    else
        echo "Pilihan tidak valid. Instalasi dibatalkan."
        exit 1
    fi
}

install_theme_ice() {
    cd /var/www/
    tar -cvf IceMinecraftTheme.tar.gz pterodactyl
    echo "Installing theme..."
    cd /var/www/pterodactyl
    rm -r IceMinecraftTheme
    git clone https://github.com/Angelillo15/IceMinecraftTheme.git
    cd IceMinecraftTheme
    rm /var/www/pterodactyl/resources/scripts/IceMinecraftTheme.css
    rm /var/www/pterodactyl/resources/scripts/index.tsx
    rm /var/www/pterodactyl/resources/scripts/components/server/console/Console.tsx
    mv resources/scripts/index.tsx /var/www/pterodactyl/resources/scripts/index.tsx
    mv resources/scripts/IceMinecraftTheme.css /var/www/pterodactyl/resources/scripts/IceMinecraftTheme.css
    mv resources/scripts/components/server/console/Console.tsx /var/www/pterodactyl/resources/scripts/components/server/console/Console.tsx
    cd /var/www/pterodactyl
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    apt update
    apt install -y nodejs
    npm i -g yarn
    yarn
    yarn build:production
    sudo php artisan optimize:clear
}

delete_files_ptero() {
    echo "PROSES"
    echo "Menjalankan perintah Anda"
    echo "APAKAH ANDA INGIN MENGUNINSTAL FILE PTERODACTYL? (YES/NO)"
    read -r HAS_PTERODACTYL

    if [ "$HAS_PTERODACTYL" == "YES" ] || [ "$HAS_PTERODACTYL" == "yes" ]; then
        cd /var/ && rm -r www
        echo "FILE PTERODACTYL TELAH TER UNINSTALL"
    elif [ "$HAS_PTERODACTYL" == "NO" ] || [ "$HAS_PTERODACTYL" == "no" ]; then
        echo "Instalasi tema Enigma dibatalkan karena Anda tidak memiliki panel Pterodactyl."
        exit 1
    else
        echo "Pilihan tidak valid. Instalasi dibatalkan."
        exit 1
    fi
}

# Fungsi untuk menangani pilihan "INSTALL THEME ENIGMA"
install_theme_enigma() {
    echo "Anda memilih untuk menginstal tema Enigma."
    echo "Menjalankan perintah instalasi tema Enigma..."
    echo "KAMU HARUS MEMILIKI PANEL PTERODACTYL TERLEBIH DAHULU! APAKAH ANDA MEMPUNYAINYA? (YES/NO)"
    read -r HAS_PTERODACTYL

    if [ "$HAS_PTERODACTYL" == "YES" ] || [ "$HAS_PTERODACTYL" == "yes" ]; then
        echo "Instalasi tema Enigma dimulai..."
        cd /var/www && wget https://download1532.mediafire.com/jgxrnebihivgsD7QzyXJzHuVdHF9t32QdWw5hCT1GUEimrT0rTIxt22C0AEz5mv-eqrCfpTcRt2kIj_z1HTHZoX0DJW3qpfxRgdZcld44HBp3kKn6faPrE9X2Ofda8kbHuyLnrT1J5f1JVh1iSFHd8CE55zlf3MbGenuYvOAqWo/cleu1ftfo2pcqmz/ENIGMA+PREMIUM+REMAKE+BY+RAINSTOREID.zip
        unzip ENIGMA+PREMIUM+REMAKE+BY+RAINSTOREID.zip
        cd /var/www/ENIGMA && cp -r panel/ /var/www/pterodactyl
        cd /var/www/pterodactyl
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        apt update
        apt install -y nodejs
        npm i -g yarn
        yarn
        yarn build:production
        echo "Instalasi tema Enigma selesai."
    elif [ "$HAS_PTERODACTYL" == "NO" ] || [ "$HAS_PTERODACTYL" == "no" ]; then
        echo "Instalasi tema Enigma dibatalkan karena Anda tidak memiliki panel Pterodactyl."
        exit 1
    else
        echo "Pilihan tidak valid. Instalasi dibatalkan."
        exit 1
    fi
}

# Skrip utama
clear
echo ""
animate_text "MENYIAPKAN LISENSI ANDA..." 0.1
echo ""

if [ ! -f "$LICENSE_FILE" ]; then
    request_license
fi

check_license
if [ $? -eq 0 ]; then
    display_message

    while true; do
        echo ""
        echo -e "${YELLOW}Pilih menu yang tersedia:${RESET}"
        echo "1. INSTALL THEME ICE"
        echo "2. DELETE FILES PTERO"
        echo "3. FIX YARN"
        echo "4. INSTALL THEME ENIGMA"
        echo "5. EXIT"
        echo ""
        read -p "Masukkan pilihan Anda (1-5): " PILIHAN

        case $PILIHAN in
            1)
                install_theme_ice
                ;;
            2)
                delete_files_ptero
                ;;
            3)
                fix_yarn
                ;;
            4)
                install_theme_enigma
                ;;
            5)
                echo "Terima kasih telah menggunakan skrip ini."
                exit 0
                ;;
            *)
                echo "Pilihan tidak valid. Silakan coba lagi."
                ;;
        esac
    done
else
    install_software
fi
