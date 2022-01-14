{ self, lib, ... }:
let
  inherit (builtins) attrNames;
  inherit (lib) genAttrs mapAttrs';
in rec {
  ## Packager Functions ##
  # Device Configurations
  device = attrs:
    mapAttrs' (_: name: {
      name = "Device-${name}";
      value = attrs.${name}.config.system.build.toplevel;
    }) (genAttrs (attrNames attrs) (name: "${name}"));

  # User Home Configurations
  user = user:
    mapAttrs' (_: name: {
      name = "User-${name}";
      value = self.homeConfigurations.${user}.activationPackage;
    }) (genAttrs (attrNames self.homeConfigurations) (name: "${name}"));
}
