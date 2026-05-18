#!/bin/bash

# Hermes Agent - Termux Installer (Python 3.13 Compatible)
# Repository: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android

set -e

GRN='\033[0;32m'
CYN='\033[0;36m'
YEL='\033[0;33m'
RST='\033[0m'

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}         HERMES AGENT - TERMUX INSTALLER${RST}"
echo -e "${CYN}=====================================================${RST}"

# Fix apt prompts
export DEBIAN_FRONTEND=noninteractive

# Update packages first
echo -e "${GRN}📦 Updating package lists...${RST}"
pkg update -y -o Dpkg::Options::="--force-confnew" 2>/dev/null || pkg update -y

# Install Python 3.13 (current version)
echo -e "${GRN}🐍 Installing Python...${RST}"
pkg install -y python

# PATCH: Fix psutil compatibility with Python 3.13 on Termux
# This removes the unsupported compiler flag -fno-openmp-implicit-rpath
echo -e "${GRN}🔧 Patching Python sysconfig for psutil compatibility...${RST}"
_file="$(find $PREFIX/lib/python3.* -name "_sysconfigdata*.py" 2>/dev/null | head -1)"
if [ -f "$_file" ]; then
    cp "$_file" "$_file.backup"
    sed -i 's|-fno-openmp-implicit-rpath||g' "$_file"
    rm -rf $PREFIX/lib/python3.*/__pycache__
    echo -e "${GRN}✅ Python patched successfully${RST}"
else
    echo -e "${YEL}⚠️ Python sysconfig file not found, continuing...${RST}"
fi

# Install other dependencies
echo -e "${GRN}📦 Installing other dependencies...${RST}"
pkg install -y git clang rust make pkg-config libffi openssl nodejs ripgrep ffmpeg

# Clone repository
echo -e "${GRN}📥 Cloning Hermes Agent...${RST}"
rm -rf hermes-agent 2>/dev/null
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Setup Python virtual environment
echo -e "${GRN}🐍 Setting up Python virtual environment...${RST}"
python -m venv venv
source venv/bin/activate

# Set Android API level
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk 2>/dev/null || echo 24)"

# Upgrade pip
python -m pip install --upgrade pip setuptools wheel

# Install Hermes with Termux extra
echo -e "${GRN}🔧 Installing Hermes Agent...${RST}"
python -m pip install -e '.[termux]' -c constraints-termux.txt

# Create global symlink
ln -sf "$PWD/venv/bin/hermes" "$PREFIX/bin/hermes"

echo -e "${GRN}=====================================================${RST}"
echo -e "${GRN}✅ Hermes Agent installed successfully!${RST}"
echo -e "${GRN}=====================================================${RST}"
echo ""
echo -e "${CYN}🔥 Run 'hermes' to start using it${RST}"
echo -e "${CYN}🔧 Run 'hermes setup' for configuration${RST}"
echo -e "${CYN}📖 Type 'hermes --help' for more options${RST}"
echo ""
echo -e "${GRN}💡 Need help? Visit:${RST} https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"
