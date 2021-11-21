{ config, files, secrets, username, lib, inputs, ... }:
let
  pc = (config.device == "PC");
  iso = (config.device == "ISO");
in rec
{
  ## Device User Configuration ##
  config = lib.mkIf (pc || iso)
  (lib.mkMerge
  [
    {
      users.mutableUsers = false;

      # Root User
      users.extraUsers.root.initialHashedPassword = secrets.root;

      # Security Settings
      security.sudo.extraConfig =
      ''
        Defaults pwfeedback
        Defaults lecture = never
      '';
    }

    (lib.mkIf pc
    {
      # Password
      users.users."${username}".initialHashedPassword = secrets."${username}";

      # Wallpapers
      home-manager.users."${username}".home.file.".local/share/backgrounds".source = files.wallpapers;
    })

    (lib.mkIf iso
    {
      # User Login
      services.xserver.displayManager.autoLogin =
      {
        enable = true;
        user = "nixos";
      };

      # Default User
      users.users.nixos =
      {
        name = "nixos";
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        uid = 1000;
        initialPassword = "password";
        useDefaultShell = true;
      };

      # Security Settings
      security.sudo.extraConfig = "nixos ALL=(ALL) NOPASSWD:ALL";
    })
  ]);
}