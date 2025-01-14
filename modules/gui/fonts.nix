{
  config,
  lib,
  pkgs,
  files,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.gui.fonts) enable usrshare;
in {
  options.gui.fonts = {
    enable = mkEnableOption "Enable Fonts Configuration";
    usrshare = mkEnableOption "Create`/usr/share/fonts` and fill it with the system fonts";
  };

  ## Font Configuration ##
  config = mkIf enable {
    fonts = {
      enableDefaultFonts = true;
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      fontconfig = {
        enable = true;
        localConf = files.fonts.config;
        defaultFonts = {
          monospace = ["MesloLGS NF"];
          sansSerif = ["Product Sans"];
          serif = ["Noto Serif"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    # Font Packages
    fonts.fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira
      fira-code
      fira-mono
      liberation_ttf
      meslo-lgs-nf
      noto-fonts
      noto-fonts-emoji
      roboto
      roboto-slab
      source-code-pro
      ttf_bitstream_vera
      ubuntu_font_family

      # Patched Nerd Fonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
          "Hack"
          "JetBrainsMono"
          "RobotoMono"
          "SourceCodePro"
        ];
      })

      # Custom Fonts
      custom.fonts
    ];

    ## Font Compatibility
    systemd.tmpfiles.rules = with pkgs; let
      x11Fonts = runCommand "X11-fonts" {preferLocalBuild = true;} ''
        mkdir -p "$out"
        font_regexp='.*\.\(ttf\|ttc\|otf\|pcf\|pfa\|pfb\|bdf\)\(\.gz\)?'
        find ${toString config.fonts.fonts} -regex "$font_regexp" \
          -exec cp '{}' "$out" \;
        cd "$out"
        ${gzip}/bin/gunzip -f *.gz
        ${xorg.mkfontscale}/bin/mkfontscale
        ${xorg.mkfontdir}/bin/mkfontdir
        cat $(find ${xorg.fontalias}/ -name fonts.alias) >fonts.alias
      '';
    in
      if usrshare
      then ["L+ /usr/share/fonts - - - - ${x11Fonts}"]
      else [
        "r /usr/share/fonts - - - - -"
        "r /usr/share - - - - -"
      ];
  };
}
