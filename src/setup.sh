#! /usr/bin/env bash
# My NixOS Setup Script
# Shows the output of every command
set +x

# System Setup
setup_system()
{
  printf "Setting up System...\nDeleting /etc/nixos ->\n"
  sudo rm -rf /etc/nixos
  printf "Creating profiles.nix ->\n"
  echo "# Auto-generated by setup script" >> ../volatile/profiles.nix
  echo "{ config, lib, pkgs, ... }: { imports = [" >> ../volatile/profiles.nix
  printf "Adding root user ->\n"
  echo "../users/root " >> ../volatile/profiles.nix
  read -p "Enter path to NixOS configuration files: " path
  echo $path >> ../volatile/path
}

# Device Specific Setup
setup_vortex()
{
  printf "Setting up Vortex... ->\n"
  echo "../modules/devices/vortex" >> ../volatile/profiles.nix
}

setup_futura()
{
  printf "Setting up Futura... ->\n"
  echo "../modules/devices/futura" >> ../volatile/profiles.nix
}

# Setup for User V7
setup_v7()
{
  printf "Setting up User V7...\nCreating Screenshots Directory ->\n"
  mkdir -p /home/v7/Pictures/Screenshots
  printf "Setting Profile Picture ->\n"
  sudo cp -av ../users/v7/config/images/Profile.png /var/lib/AccountsService/icons/v7
  printf "Adding user V7 ->\n"
  echo "../users/v7" >> ../volatile/profiles.nix
}

# Setup for User Navya
setup_navya()
{
  printf "Setting up User Navya...\nCreating Screenshots Directory ->\n"
  mkdir -p /home/navya/Pictures/Screenshots
  printf "Setting Profile Picture -> "
  sudo cp -av ../users/navya/config/images/Profile.png /var/lib/AccountsService/icons/navya
  printf "Adding user Navya ->\n"
  echo "../users/navya" >> ../volatile/profiles.nix
}

# Rebuild System
rebuild()
{
  printf "Rebuilding System... ->\n"
  sudo nixos-rebuild switch -I nixos-config=../configuration.nix
}

read -p "Do you want to setup the system? (Y/N): " choice
  case $choice in
      [Yy]* ) setup_system; printf "\n";;
      [Nn]* ) exit;;
      * ) echo "Please answer (Y)es or (N)o.";;
  esac

read -p "Do you want to setup Vortex or Futura? (1/2): " choice
  case $choice in
      [1]* ) setup_vortex; printf "\n";;
      [2]* ) setup_futura; printf "\n";;
      * ) echo "Please answer (1)Vortex or (2)Futura.";;
  esac

read -p "Do you want to setup user V7? (Y/N): " choice
  case $choice in
      [Yy]* ) setup_v7; printf "\n";;
      [Nn]* ) printf "\n";;
      * ) echo "Please answer (Y)es or (N)o.";;
  esac

read -p "Do you want to setup user Navya? (Y/N): " choice
  case $choice in
      [Yy]* ) setup_navya; printf "\n";;
      [Nn]* ) printf "\n";;
      * ) echo "Please answer (Y)es or (N)o.";;
  esac

echo "]; }" >> ./volatile/profiles.nix

read -p "Do you want to rebuild the system? (Y/N): " choice
  case $choice in
      [Yy]* ) rebuild; exit;;
      [Nn]* ) exit;;
      * ) echo "Please answer (Y)es or (N)o.";;
  esac