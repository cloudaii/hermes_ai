#!/bin/bash

# Hermes Agent - One-line installer for Termux (Android)
# Usage: curl -fsSL https://your-raw-url/hermes_install.sh | bash

set -e

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}                   THEVOIDKERNEL"
echo -e "${CYN}=====================================================${RST}"

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}        🚀 Installing Hermes Agent on Termux..."
echo -e "${CYN}=====================================================${RST}"

echo "📦 Repository: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"


# Update packages
pkg update && pkg upgrade -y

# Install dependencies
pkg install -y git python clang rust make pkg-config libffi openssl nodejs ripgrep ffmpeg

# Clone repository
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git

# Navigate to directory
cd hermes-agent

# Setup Python virtual environment
python -m venv venv
source venv/bin/activate

# Set Android API level
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"

# Upgrade pip tools
python -m pip install --upgrade pip setuptools wheel

# Install Hermes with Termux support
python -m pip install -e '.[termux]' -c constraints-termux.txt

# Create global symlink
ln -sf "$PWD/venv/bin/hermes" "$PREFIX/bin/hermes"

echo "✅ Hermes Agent installed successfully!"
echo "🔥 Run 'hermes' or 'hermes setup' to start using it"
echo "📖 Type 'hermes --help' for more options"
echo ""
echo "💡 Need help? Visit: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"
echo ""

echo "🌐 Run 'hermes gateway' to run deply it"


