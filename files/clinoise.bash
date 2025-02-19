#!/bin/bash

# Vars
bold='[1m'
black='[30m'
red='[31m'
green='[32m'
yellow='[33m'
blue='[34m'
magenta='[35m'
cyan='[36m'
white='[37m'
grey='[90m'
reset='[0m'


if ! figlet "test"; then
  echo "Please install figlet."
  echo "Instructions are at http://www.figlet.org/."
  if ! return 1; then
    exit 1
  fi
else
  clear
fi

# Set flag default vars
quiet="0"
nopersonalinfo="0"

# Retreive data
ID=$(lsb_release -is)
DS=$(lsb_release -ds)
RN=$(lsb_release -rs)
HN=$(hostname)
USR=$(whoami)

echo "$@"

case $@ in
  *q | --quiet*)
    quiet="1"
    ;;
  *p | --no-personal-info*)
    nopersonalinfo="1"
    ;;
  *h | --help*)
    echo "Usage: clinoise [OPTIONS]"
    echo "OPTIONS: "
    echo "    q --quiet           : Quiet, simple output; false"
    echo "    p --no-personal-info: Do not include information that could identify you; false"
    echo "    h --help            : Show this prompt"
    if ! return 1; then
      exit 1
    fi
    ;;
  $null)
  ;;
esac

# COLORS (You can change)
LOGOCOLOR=${blue}
DISTROCOLOR=${bold}${LOGOCOLOR} # Distro: etc...
HOSTCOLOR=${bold}${red} # Host: etc...
USERCOLOR=${bold}${yellow} # User: etc...
FONTSCOLOR=${bold}${green} # Fonts: etc...

# Data
GENLOGO=$(echo "$ID" | figlet -f slant)
LOGO="${LOGOCOLOR}$GENLOGO${reset}"
if [[ $quiet = "1" ]]; then
  DISTRO="${DISTROCOLOR}Distro: $ID ${reset}"
else
  DISTRO="${DISTROCOLOR}Distro: $ID $DS $RN ${reset}"
fi

if [[ $nopersonalinfo = "0" ]]; then
  HOST="${HOSTCOLOR}Host: $HN ${reset}"
  USERNAME="${USERCOLOR}User: $USR ${reset}"
fi

# Colors
COLORS="${red}███${green}███${yellow}███${blue}███${magenta}███${cyan}███${reset}"

# List Fonts
FONTS="${FONTSCOLOR}Fonts: $(fc-list | wc -l)${reset}"

cat <<EOF

${LOGO}
${COLORS}
${DISTRO}
${HOST}
${USERNAME}
${FONTS}
EOF
