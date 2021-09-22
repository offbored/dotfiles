#! /usr/bin/env bash
# My NixOS Setup Script
# Shows the output of every command
set +x

# Precautionary Measure
rm -f ./volatile/device.nix
rm -f ./volatile/path

# System Setup
setup_system()
{
  read -p "Do you want to setup the system? (Y/N): " choice
    case $choice in
      [Yy]* ) ;;
      [Nn]* ) exit;;
      * ) echo "Please answer (Y)es or (N)o.";;
    esac
  printf "Setting up System...\n"
  sudo rm -rf /etc/nixos
  echo "[" >> ./volatile/device.nix
  echo "../users/root " >> ./volatile/device.nix
  read -p "Enter path to NixOS configuration files: " path
  echo $path >> ./volatile/path
}

# Device Specific Setup
setup_vortex()
{
  printf "Setting up Vortex...\n"
  echo "../modules/devices/vortex" >> ./volatile/device.nix
}

setup_futura()
{
  printf "Setting up Futura...\n"
  echo "../modules/devices/futura" >> ./volatile/device.nix
}

setup_device()
{
  read -p "Do you want to setup the device Vortex or Futura? (1/2): " choice
    case $choice in
      [1]* ) setup_vortex;;
      [2]* ) setup_futura;;
      * ) echo "Please answer (1)Vortex or (2)Futura.";;
    esac
}

# Setup for User V7
setup_user()
{
  printf "Setting up User V7...\n"
  echo "../users/v7" >> ./volatile/device.nix
  mkdir -p /home/v7/Pictures/Screenshots
  printf "<- Setting Profile Picture ->\n"
  sudo cp -av ./users/v7/config/images/Profile.png /var/lib/AccountsService/icons/v7
}

# Rebuild System
rebuild()
{
  read -p "Do you want to rebuild the system? (Y/N): " choice
    case $choice in
      [Yy]* ) ;;
      [Nn]* ) exit;;
      * ) echo "Please answer (Y)es or (N)o.";;
    esac
  printf "Rebuilding System...\n"
  sudo nixos-rebuild switch -I nixos-config=./configuration.nix
}

# Function Call
setup_system
printf "\n"
setup_device
printf "\n"
setup_user
printf "\n"
echo "]" >> ./volatile/device.nix
rebuild
