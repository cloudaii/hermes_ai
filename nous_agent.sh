#!/data/data/com.termux/files/usr/bin/bash

set -e

# Colors
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[1;33m'
CYN='\033[0;36m'
RST='\033[0m'

clear

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}                THEVOIDKERNEL"
echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}         ☤ HERMES AGENT TERMUX INSTALLER ☤"
echo -e "${CYN}=====================================================${RST}"

echo -e "${YLW}Updating packages and handling prompts...${RST}"

# --- Termux Level Commands (Fixes the Y/N prompt from your image) ---
export DEBIAN_FRONTEND=noninteractive
pkg update -y -o Dpkg::Options::="--force-confold"
pkg upgrade -y -o Dpkg::Options::="--force-confold"
pkg install proot-distro -y

# Install Ubuntu (Check if already installed to avoid error)
if ! proot-distro list | grep -q "Installed: yes" | grep "ubuntu"; then
    proot-distro install ubuntu
fi

# Use proot-distro login with -- to execute commands inside Ubuntu
proot-distro login ubuntu -- bash -c "
    export DEBIAN_FRONTEND=noninteractive
    apt update && apt upgrade -y -o Dpkg::Options::='--force-confold'
    apt install python3 python3-pip python3-venv git curl build-essential nodejs npm -y

    if [ ! -d \"hermes-agent\" ]; then
        git clone https://github.com/NousResearch/hermes-agent.git
    fi
    
    cd hermes-agent

    python3 -m venv venv
    source venv/bin/activate

    pip install --upgrade pip
    pip install -e .
"

echo -e "${CYN}===================================================${RST}"
echo -e "${GRN}     ✅ Hermes Agent installed successfully!"
echo -e "${CYN}===================================================${RST}"

echo "📖 Type 'proot-distro login ubuntu' to enter your environment"
echo "💡 Need help? Visit: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"

echo -e "${YLW}Run "hermes setup" for onboarding${RST}"
echo -e "${YLW}Run "hermes" to use ${RST}"

echo " "
echo -e "${CYN}START FRESH HERMES AFTER CLOSING TERMUX${RST}"
echo " "
echo -e "${YLW}proot-distro login ubuntu${RST}"
echo " "
echo -e "${YLW}cd hermes-agent${RST}"
echo " "
echo -e "${YLW}source venv/bin/activate${RST}"
echo " "
echo -e "${CYN}hermes${RST}"