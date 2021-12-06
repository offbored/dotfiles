{ self, ... } @ inputs:
let
  ## Variable Declaration ##
  # System Architecture
  system = "x86_64-linux";

  # NixOS Version
  version = (builtins.readFile ./version);

  # System Libraries
  inherit (builtins) head attrValues;
  inherit (inputs.nixpkgs) lib;

  # Custom Functions
  util = import ./lib { inherit system version lib util inputs pkgs files; };
  inherit (util) build map;

  # Package Configuration
  filterHosts = pkgs: cfgs: (pkgs.lib.filterAttrs (n: v: pkgs.system == v.config.nixpkgs.system) cfgs);
  unstable = map.packages inputs.unstable [ ] [ ];
  pkgs = map.packages inputs.nixpkgs [ self.overlay inputs.nur.overlay ] ./packages/patches;

  # Dotfiles and Program Configuration
  files = import ./files;
in
{
  ## Developer Shells ##
  # Default Developer Shell
  devShell."${system}" = import ./shells { inherit pkgs; };

  # Tailored Developer Shells
  devShells."${system}" = map.modules ./shells (name: import name { inherit pkgs; });

  ## Package Configuration ##
  legacyPackages."${system}" = (head (attrValues self.nixosConfigurations)).pkgs;

  # Overrides
  overlay = final: prev: { inherit unstable; custom = self.packages."${system}"; };
  overlays = map.modules ./packages/overlays import;

  # Custom Packages
  packages."${system}" = map.modules ./packages (name: pkgs.callPackage name { inherit pkgs files; });

  ## Custom Configuration Modules ##
  nixosModules = map.modules ./modules import;

  ## Install Media Configuration ##
  checks."${system}" = map.checks.system self.installMedia;
  installMedia =
  {
    # Install Media - GNOME
    gnome = build.iso
    {
      name = "nixos";
      timezone = "Asia/Kolkata";
      locale = "en_IN.UTF-8";
      kernel = pkgs.linuxKernel.packages.linux_5_15;
      desktop = "gnome";
    };
  };

  ## Device Configuration ##
  nixosConfigurations =
  {
    # PC - Dell Inspiron 15 5000
    Vortex = build.device
    {
      name = "Vortex";
      timezone = "Asia/Kolkata";
      locale = "en_IN.UTF-8";
      kernel = pkgs.linuxKernel.packages.linux_lqx;
      kernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];

      hardware =
      {
        boot = "efi";
        cores = 8;
        filesystem = "advanced";
        support = [ "mobile" "printer" "ssd" "virtualisation" ];
      };

      desktop = "gnome";
      apps =
      {
        list = [ "discord" "firefox" "git" "office" ];
        git =
        {
          name = "maydayv7";
          mail = "maydayv7@gmail.com";
        };
      };

      # User V7
      user =
      {
        name = "v7";
        description = "V 7";
        groups = [ "wheel" "keys" ];
        uid = 1000;
        shell =
        {
          choice = "zsh";
          utilities = true;
        };
      };
    };

    # PC - Dell Inspiron 11 3000
    Futura = build.device
    {
      name = "Futura";
      timezone = "Asia/Kolkata";
      locale = "en_IN.UTF-8";
      kernel = pkgs.linuxKernel.packages.linux_5_4;
      kernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];

      hardware =
      {
        boot = "efi";
        cores = 4;
        filesystem = "simple";
      };

      desktop = "gnome";
      apps.list = [ "firefox" "office" ];

      # User Navya
      user =
      {
        name = "navya";
        description = "Navya";
        shell.choice = "zsh";
      };
    };
  };
}
