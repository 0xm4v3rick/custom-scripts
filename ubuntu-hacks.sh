#!/bin/bash

# Author @0xm4v3rick
# Customization for fresh Ubuntu installation
# Tested on Ubuntu 16.04

RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

if [[ "${EUID}" -ne 0 ]]; then
  echo -e "\n"${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}" 1>&2
  echo -e "\n"${RED}'[!]'${RESET}" Quitting..." 1>&2
  exit 1
else
  echo -e "\n\n ${BLUE}[*]${RESET} ${BOLD}Setting up ${GREEN}XFCE ......${RESET}"
  sleep 2s
fi

echo -e "\n\n ${GREEN}[+]${RESET} Running ${GREEN}apt-get update${RESET}${RESET}"
apt-get -qq update \
  || echo -e ' '${RED}'[!] Issue with apt-get update'${RESET} 1>&2


echo -e "\n\n ${GREEN}[+]${RESET} Installing ${GREEN}XFCE4 and stuff ...........${RESET}${RESET}"
apt -y -qq install xfce4 xfce4-goodies xfce4-panel xfce4-terminal xfce4-mount-plugin xfce4-notifyd xfce4-places-plugin xfce4-power-manager xfce4-battery-plugin \
  || echo -e ' '${RED}'[!] Issue with apt install XFCE4 stuff'${RESET} 1>&2

echo -e "\n\n ${GREEN}[+] Setup Complete - Reboot and start H4cking ...........${RESET}${RESET}"

