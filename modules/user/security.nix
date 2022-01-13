{ config, lib, ... }:
let
  inherit (lib) map mkIf;
  enable = config.user.password == "";
  secrets = config.sops.secrets;
  username = config.user.name;
in rec
{
  config = mkIf enable
  {
    # Passwords
    sops.secrets = map.secrets ./passwords true;
    user.settings.passwordFile = secrets."${username}".path;
    users.extraUsers.root.passwordFile = secrets."root".path;

    # Security Settings
    security.sudo.extraConfig =
    ''
      Defaults pwfeedback
      Defaults lecture = never
    '';
  };
}
