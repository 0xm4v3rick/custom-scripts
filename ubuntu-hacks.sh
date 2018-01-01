#!/bin/bash

# Author @0xm4v3rick
# Customization for fresh Ubuntu installation
# Tested on Ubuntu 16.04
# Reference: https://github.com/g0tmi1k/os-scripts/blob/master/kali-rolling.sh
# Usage: 
#	1st run : sudo bash hack.sh 1
#	2nd run : sudo -E bash script.sh 2 $USER

RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

if [[ "${EUID}" -ne 0 ]]; then
  echo -e "\n"${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}" 1>&2
  echo -e "\n"${RED}'[!]'${RESET}" Quitting..." 1>&2
  exit 1  
fi

if [ $1 -eq 1 ]
then

echo -e "\n\n ${BLUE}[*]${RESET} ${BOLD}Setting up ${GREEN}XFCE ......${RESET}"
echo -e "\n\n ${GREEN}[+]${RESET} Running ${GREEN}apt-get update${RESET}${RESET}"
apt-get -qq update \
  || echo -e ' '${RED}'[!] Issue with apt-get update'${RESET} 1>&2


echo -e "\n\n ${GREEN}[+]${RESET} Installing ${GREEN}XFCE4 and stuff ...........${RESET}${RESET}"
apt -y -qq install xfce4 xfce4-goodies xfce4-panel xfce4-terminal xfce4-mount-plugin xfce4-notifyd xfce4-places-plugin xfce4-power-manager xfce4-battery-plugin \
  || echo -e ' '${RED}'[!] Issue with apt install XFCE4 stuff'${RESET} 1>&2

echo -e "\n\n ${GREEN}[+] Reboot and continue with 'sudo -E bash script.sh 2 \$USER' ...........${RESET}${RESET}"
fi

if [ $1 -eq 2 ]
then
echo -e "\n\n ${GREEN}[+]${RESET} Installing ${GREEN}terminator ..... ${RESET}${RESET}"
sudo apt -y install terminator \
	|| echo -e ' '${RED}'[!] Issue with apt install terminator'${RESET} 1>&2

echo -e "\n\n ${GREEN}[+]${RESET} Setting up ${GREEN}terminator ..... ${RESET}${RESET}"

mkdir -p ~/.config/terminator/
touch ~/.config/terminator/config
file=~/.config/terminator/config
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
[global_config]
  enabled_plugins = TerminalShot, LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
[keybindings]
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    background_darkness = 0.9
    background_type = transparent
    copy_on_selection = True
    font = DejaVu Sans Mono 11
    scrollback_infinite = True
    show_titlebar = False
    use_system_font = False

EOF

echo -e "\n\n ${GREEN}[+]${RESET} Downloading ${GREEN}axiomd theme ..... ${RESET}${RESET}"
timeout 300 curl --progress -k -L -f "https://dl.opendesktop.org/api/files/downloadfile/id/1461767736/s/957db7fc253362cc85033fff6d14a9b5/t/1514811810/90145-axiom.tar.gz" > /tmp/axiom.tar.gz \
	|| echo -e ' '${RED}'[!] Issue downloading axiomd theme, exiting........'${RESET} 1>&2


echo -e "\n\n ${GREEN}[+]${RESET} Setting up ${GREEN}axiomd ..... ${RESET}${RESET}"
mkdir -p ~/.themes/
tar -zxf /tmp/axiom.tar.gz -C ~/.themes/

su $2 -m -c 'xfconf-query -n -c xsettings -p /Net/ThemeName -s "axiomd"
xfconf-query -n -c xsettings -p /Net/IconThemeName -s "elementary-xfce-dark"
xfconf-query -c xfwm4 -p /general/theme -s "axiomd"
'

echo -e "\n\n ${GREEN}[+] Setup Complete - Reboot and start H4cking ...........${RESET}${RESET}"
fi
