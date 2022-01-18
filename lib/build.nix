{ self, systems, lib, ... }:
let
  inherit (lib) nameValuePair util;
  inherit (builtins) any attrValues isPath listToAttrs map readFile;
in rec {
  ## Builder Functions ##
  eachSystem = func:
    listToAttrs (map (name: nameValuePair name (func name)) systems);

  # Configuration Builders
  device = self.nixosModule.config;
  iso = config:
    self.nixosModule.config (config // {
      format = "iso";
      description = "Install Media";
      kernelModules = [ "nvme" ];

      # Default User
      user = {
        name = "nixos";
        description = "Default User";
        autologin = true;
        password = readFile ../modules/user/passwords/default;
      };
    });

  # Package Channels Builder
  channel = src: overlays: patch:
    let patches = util.map.patches patch;
    in eachSystem (system:
      (if !(any isPath patches) then
        import src
      else
        import (src.legacyPackages."${system}".applyPatches {
          inherit src patches;
          name = "Patched-input-${src.shortRev}";
        })) {
          inherit system;
          overlays = overlays ++ (attrValues self.overlays or { }) ++ [
            (final: prev:
              {
                custom = self.packages."${system}";
              } // self.channels."${system}")
          ];
          config = {
            allowAliases = true;
            allowBroken = false;
            allowUnfree = true;
          };
        });
}
