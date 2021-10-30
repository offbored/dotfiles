{ config, lib, ... }:
let
  cfg = config.base.enable;
in rec
{
  ## User Configuration ##
  config = lib.mkIf (cfg == true)
  {
    # Nix Permissions
    nix.trustedUsers = [ "root" "@wheel" ];

    # Root User
    users.extraUsers.root.initialPassword = "";

    # Default User
    users.users.nixos =
    {
      name = "nixos";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      uid = 1000;
      initialPassword = "";
      useDefaultShell = true;
    };

    # Security Settings
    security =
    {
      sudo.extraConfig =
      "
        Defaults lecture = never
        nixos ALL=(ALL) NOPASSWD:ALL
      ";
    };
  };
}
