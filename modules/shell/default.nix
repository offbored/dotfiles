{ config, files, username, lib, pkgs, ... }:
let
  enable = config.shell.enable;
  shell = config.shell.shell;
in rec
{
  imports = [ ./zsh.nix ];

  options.shell =
  {
    enable = lib.mkEnableOption "Enable Shell Configuration";
    shell = lib.mkOption
    {
      description = "User Shell Choice";
      type = lib.types.str;
      default = "bash";
    };
  };

  ## Shell Configuration ##
  config = lib.mkIf enable
  {
    # Environment Variables
    environment.variables =
    {
      EDITOR = "nano";
    };

    # User Configuration
    users.users."${username}" =
    {
      useDefaultShell = false;
      shell = pkgs."${shell}";
    };

    # Shell Environment
    environment =
    {
      shells = with pkgs; [ bashInteractive zsh ];
      pathsToLink = [ "/share/zsh" ];
    };

    # Utilities
    environment.systemPackages = with pkgs;
    [
      exa
      fd
      file
      lolcat
      neofetch
    ];

    # Neofetch Config
    home-manager.users."${username}".home.file.".config/neofetch/config.conf".text = files.neofetch;

    programs =
    {
      # Command Not Found Helper
      command-not-found.enable = true;

      # GPG Key Signing
      gnupg.agent.enable = true;

      # X11 SSH Password Auth
      ssh.askPassword = "";
    };
  };
}