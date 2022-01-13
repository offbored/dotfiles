{ pkgs, ... }: rec {
  ## Console Configuration ##
  config = {
    # Setup
    console = {
      font = "ter-132n";
      packages = [ pkgs.terminus_font ];
      useXkbConfig = true;
    };

    # TTY
    fonts.fonts = [ pkgs.meslo-lgs-nf ];
    services.kmscon = {
      enable = true;
      hwRender = true;
      extraConfig = ''
        font-name=MesloLGS NF
        font-size=14
      '';
    };

    # Essential Utilities
    environment.systemPackages = with pkgs; [
      git
      git-crypt
      gnupg
      gparted
      killall
      parted
      pciutils
      unrar
      unzip
      wget
    ];
  };
}
