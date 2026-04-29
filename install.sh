#!/bin/bash

# Masters Vercel Deployer - Enterprise Installer
C_CYAN='\033[38;5;51m'
C_GREEN='\033[38;5;46m'
C_RED='\033[38;5;196m'
C_YELLOW='\033[38;5;226m'
C_PURPLE='\033[38;5;135m'
C_RESET='\033[0m'

clear
echo -e "${C_PURPLE}╔════════════════════════════════════════════════════════════╗${C_RESET}"
echo -e "${C_PURPLE}║${C_RESET} ${C_CYAN}      M@☆ FRAMEWORK INSTALLER - ENTERPRISE EDITION      ${C_RESET} ${C_PURPLE}║${C_RESET}"
echo -e "${C_PURPLE}╚════════════════════════════════════════════════════════════╝${C_RESET}"
echo ""

# THE FIX: Force read to pull from the active terminal, not the curl pipe
read -p "🔑 Enter Install PIN: " user_pin </dev/tty

# Verify the PIN
if [ "$user_pin" != "VERCEL" ]; then
    echo -e "\n${C_RED}[!] ACCESS DENIED. INCORRECT PIN.${C_RESET}"
    exit 1
fi

echo -e "\n${C_YELLOW}[*] PIN Accepted. Downloading Core Architecture...${C_RESET}"
# Download the encrypted GPG file from your GitHub
curl -sL https://raw.githubusercontent.com/M-AT-STAR/vercel/main/MastersVercelDeploy.tspy -o /tmp/Mvercel.tspy

echo -e "${C_YELLOW}[*] Decrypting and Injecting Matrix...${C_RESET}"
# Decrypt the file directly into the global /usr/local/bin directory
gpg --quiet --batch --yes --passphrase "$user_pin" --decrypt /tmp/Mvercel.tspy > /usr/local/bin/Mvercel 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${C_RED}[!] Decryption failed. Corrupted file or invalid pipeline.${C_RESET}"
    rm -f /tmp/Mvercel.tspy
    exit 1
fi

# Make it a global executable command
chmod +x /usr/local/bin/Mvercel
rm -f /tmp/Mvercel.tspy

echo -e "\n${C_GREEN}[+] Framework Deployed Successfully!${C_RESET}"
echo -e "${C_PURPLE}==============================================================${C_RESET}"
echo -e "${C_CYAN}To launch the Deployer from anywhere, simply type:${C_RESET}"
echo -e "👉 ${C_YELLOW}Mvercel${C_RESET}"
echo -e "${C_PURPLE}==============================================================${C_RESET}"
