{ config, lib, pkgs, files, ... }:
let enable = (builtins.elem "office" config.apps.list);
in rec {
  ## Office Environment Configuration ##
  config = lib.mkIf enable {
    # Applications
    environment.systemPackages = with pkgs; [
      # Productivity
      bluej
      gscan2pdf
      handbrake
      libpst
      libreoffice
      onlyoffice-bin

      # Internet
      google-chrome
      megasync
      teams
      thunderbird
      whatsapp-for-linux
      zoom-us
    ];

    user.home.home.file = {
      # Document Templates
      "Templates" = {
        source = files.templates;
        recursive = true;
      };

      # Font Rendering
      ".local/share/fonts" = {
        source = files.fonts.path;
        recursive = true;
      };
    };
  };
}
