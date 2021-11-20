{ config, lib, pkgs, ... }:
let
  device = config.device.enable;
  iso = config.iso.enable;
in rec
{
  ## Device Firmware ##
  config = lib.mkIf (device || iso)
  {
    # Drivers
    hardware =
    {
      cpu.intel.updateMicrocode = true;
      bluetooth.enable = true;
      opengl.enable = true;
      enableRedistributableFirmware = true;
    };
    environment.systemPackages = with pkgs; [ unstable.sof-firmware ];

    # Filesystem Support
    boot.supportedFilesystems = [ "vfat" "ntfs" "btrfs" ];

    # Driver Packages
    hardware.opengl.extraPackages = with pkgs; 
    [
      intel-media-driver
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
    ];

    # Audio
    sound.enable = true;
    nixpkgs.config.pulseaudio = true;
    hardware.pulseaudio =
    {
      enable = true;
      support32Bit = true;
    };

    # Network Settings
    networking =
    {
      networkmanager.enable = true;
      firewall.enable = false;
    };

    # Printing
    services.printing =
    {
      enable = true;
      drivers = with pkgs; [ gutenprint cnijfilter2 ];
    };

    # Power Management
    services.earlyoom =
    {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 90;
    };
    services.thermald.enable = true;
    powerManagement =
    {
      enable = true;
      cpuFreqGovernor = "powersave";
    };
  };
}