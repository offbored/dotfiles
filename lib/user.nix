{ pkgs, home-manager, lib, system, ... }:
with builtins;
{
  mkUser = { name, description, groups, uid, shell, passwordFile, ... }:
  {
    # user Configuration
    users.users."${name}" =
    {
      name = name;
      description = description;
      isNormalUser = true;
      group = "users";
      extraGroups = groups;
      uid = uid;
      initialPassword = "password";
      useDefaultShell = false;
      shell = shell;
      passwordFile = passwordFile;
    };
  };
  
  mkHome = { username, version, modules }:
  home-manager.lib.homeManagerConfiguration
  {
    inherit system username pkgs;
    stateVersion = version;
    homeDirectory = "/home/${username}";
    configuration =
    let
      mkmodule = name: import (../users + "/${name}");
      user_modules = map (r: mkmodule r) modules;
    in
    {
      # Modulated Configuration Imports
      imports = user_modules;
      
      # Package Configuraton
      nixpkgs.config.allowUnfree = true;
      
      # Home Manager Configuration
      systemd.user.startServices = true;
      home.username = username;
    };
  };
}