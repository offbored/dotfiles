{
  lib,
  inputs,
  pkgs,
  ...
}:
with {inherit (lib) mkAfter mkForce;}; {
  imports = [inputs.gaming.nixosModules.pipewireLowLatency];

  ## Device Firmware ##
  config = {
    # Drivers
    hardware = {
      opengl.enable = true;
      cpu.intel.updateMicrocode = true;
      enableRedistributableFirmware = true;
      pulseaudio.enable = mkForce false;
    };

    services = {
      fwupd.enable = true;
      logind.extraConfig = "HandleLidSwitch=ignore";
    };

    # Touchpad
    services.xserver.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        tappingDragLock = true;
        middleEmulation = true;
        naturalScrolling = false;
        disableWhileTyping = true;
        scrollMethod = "twofinger";
        accelSpeed = "0.7";
      };
    };

    # Driver Packages
    hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
    ];

    # Audio
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };

    nixpkgs.config.pulseaudio = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };

    # Network Settings
    user.groups = ["networkmanager"];
    environment.persist.dirs = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/var/lib/bluetooth"
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
    };

    ## Encryption
    # GPG
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    user.persist.dirs = [
      {
        directory = ".gnupg";
        mode = "0700";
      }
    ];

    # SSH
    systemd.services.sshd.preStart = mkAfter ''
      if ! [ -s "/etc/ssh/ssh_host_rsa_key" ]; then
      ssh-keygen -t "rsa" -b "4096" -f "/etc/ssh/ssh_host_rsa_key" -N ""; fi
    '';

    services.openssh = {
      enable = true;
      passwordAuthentication = true;
      permitRootLogin = mkForce "no";
      hostKeys = mkForce [];
    };

    # Power Management
    services.thermald.enable = true;
    powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
    };

    services.earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 15;
    };
  };
}
