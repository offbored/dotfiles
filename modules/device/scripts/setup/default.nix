{ config, lib, pkgs, ... }:
let
  enable = config.scripts.setup;

  # System Setup Script
  script = with pkgs; writeScriptBin "setup"
  ''
    #!${pkgs.runtimeShell}
    set +x

    if mount | grep ext4 > /dev/null; then
      DIR=/etc/nixos
    else
      DIR=/persist/etc/nixos
    fi

    echo "Preparing Directory..."
    sudo rm -rf $DIR
    sudo mkdir $DIR
    sudo chown $USER $DIR
    sudo chmod ugo+rw $DIR
    printf "\n"

    echo "Cloning Repo..."
    git clone https://github.com/maydayv7/dotfiles.git $DIR
    printf "\n"

    if [ "$DIR" == "/persist/etc/nixos" ]; then
        sudo umount -l /etc/nixos
        sudo mount $DIR
    fi

    nixos apply
  '';
in rec
{
  options.scripts.setup = lib.mkOption
  {
    description = "Script for setting up NixOS";
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf enable
  {
    environment.systemPackages = [ script ];
  };
}
