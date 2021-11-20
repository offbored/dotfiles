{ config, lib, ... }:
let
  enable = config.hardware.ssd;
in rec
{
  options.hardware.ssd = lib.mkOption
  {
    description = "SSD Configuration";
    type = lib.types.bool;
    default = false;
  };

  ## Additional SSD Settings ##
  config = lib.mkIf enable
  {
    # SSD Trim
    services.fstrim.enable = true;
  };
}