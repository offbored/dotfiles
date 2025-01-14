### Custom Configuration Modules

The `modules` directory contains custom-made pure Flakes-compatible configuration modules, which form the very core of my configuration for multiple PCs and various use-cases (If you have a working NixOS install, you can check it out using `github:maydayv7/dotfiles#nixosModules`). The following is a summary of all the present configuration options exposed by the particular module:

[`nixosModules`](./default.nix) -

- [`apps`](./apps): Module that configures various apps and/or environments -

  - `list`: List of all enabled applications - `[ "discord" "firefox" "git" "office" "wine" ]`
  - `git` -
    - `hosting` -
      - `enable`: Enable Gitea Code Hosting - `true / false`
      - `domain`: Website Domain Name - Ex. `maydayv7.io`
    - `runner`: Enable Support for `git` Runners - `"github" / "gitlab"`
  - `wine.package`: Package to use for `wine` - Ex. `pkgs.wineWowPackages.staging`

- [`base`](./base): Module that contains the base common/shared configuration

- [`gui`](./gui): Module that configures GUI Desktops/Environments and the like -

  - `desktop`: Choice of GUI Desktop - `"gnome" / "xfce"`
  - `fonts` -
    - `enable`: Enable Fonts Configuration - `true / false`
    - `usrshare`: Create`/usr/share/fonts` and fill it with the system fonts - `true / false`

- [`hardware`](./hardware): Module that configures device and additional hardware -

  - `boot`: Supported Boot Firmware - `"mbr" / "efi"`
  - `cores`: Number of CPU Cores - Ex. `4`
  - `filesystem`: Disk File System Choice - `"simple" / "advanced"` -
    - `persist`: System Files to Preserve across Reboots (while using `advanced` File System Layout)
  - `modules`: List of Hardware Configuration Modules imported from [`inputs.hardware`](https://github.com/nixos/nixos-hardware) - Ex. `[ "common-pc" ]`
  - `security`: Enable Additional Security and Hardening Settings - `true / false`
  - `support`: List of Additional Supported Hardware - `[ "mobile" "printer" "ssd" "virtualisation" ]`
  - `vm`: Configure Virtualisation Support -
    - `android`: Enable Android Virtualisation
    - `passthrough`: PCI Device IDs for VM Passthrough using VFI/O (Use [`scripts/pci.sh`](../scripts/pci.sh)) - Ex. `[ "00:02.0" "00:1c.0" ]`

- [`nix`](./nix): Module that configures the Nix Package Manager -

  - `index`: Enable Package Indexer - `"true" / "false"`

- [`user`](./user): Module that controls User Creation and Security Settings -

  - `groups`: Additional User Groups - Ex. `[ "wheel" ]`
  - `persist`: User Files to Preserve across Reboots (while using `advanced` File System Layout)
  - `home`: User Home Configuration (Alias for `home-manager.users.${username}`) -
    - `credentials`: Individual User Credentials -
      - `name`: Alternative (Work) User Name
      - `fulname`: Full User Name
      - `mail`: User Mail ID - Ex. `"nixos@localhost.org"`
      - `key`: User GPG Key - Ex. `"CF616EB19C2765E4"`
  - `settings`: User Settings (Alias for `users.users.${username}`) -
    - `autologin`: Enable Automatic User Login - `"true" / "false"`
    - `minimal`: Enable Minimal User Configuration - `"true" / "false"`
    - `recovery`: Enable User Recovery Settings - `"true" / "false"`
    - `homeConfig`: User Specific Home Configuration

- [`shell`](./shell): Module that contains User Shell Environment Configuration -
  - `utilities`: Enable Additional Shell Utilities - `true / false`
  - `support`: List of Additional Supported Shells - Ex. `[ "bash" ]`
