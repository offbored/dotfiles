{
  config,
  lib,
  pkgs,
  files,
  ...
}:
with files; let
  inherit (builtins) elem;
  inherit (config.gui) desktop;
  apps = config.environment.systemPackages;
  inherit (lib) mapAttrs' mkIf mkForce mkMerge nameValuePair util;

  # GTK+ Theme
  theme = {
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
in {
  ## XFCE Desktop Configuration ##
  config = mkIf (desktop == "xfce" || desktop == "xfce-minimal") (mkMerge [
    {
      # Session
      services.xserver = {
        desktopManager.xfce = {
          enable = true;
          enableXfwm = true;
        };

        displayManager.lightdm.greeters.gtk = {
          clock-format = "%H:%M";
          indicators = [
            "~a11y"
            "~language"
            "~spacer"
            "~clock"
            "~spacer"
            "~host"
            "~spacer"
            "~session"
            "~power"
          ];
        };
      };
    }

    # Full-Fledged XFCE Desktop Configuration
    (mkIf (desktop == "xfce") {
      # Desktop Integration
      gui.fonts.enable = true;
      services.bamf.enable = true;
      services.xserver.displayManager.lightdm.greeters.gtk = theme;
      programs.gnupg.agent.pinentryFlavor =
        mkIf config.programs.gnupg.agent.enable "gtk2";

      # Plugins
      programs = {
        xfconf.enable = true;
        thunar.plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-dropbox-plugin
          thunar-volman
        ];
      };

      # Utilities
      environment.systemPackages = with pkgs.xfce // pkgs; [
        pavucontrol
        plank
        orage
        xarchiver
        mate.atril
        xfce4-clipman-plugin
        xfce4-eyes-plugin
        xfce4-notes-plugin
        xfce4-panel-profiles
        xfce4-pulseaudio-plugin
        xfce4-sensors-plugin
        xfce4-timer-plugin
        xfce4-weather-plugin
        xfce4-whiskermenu-plugin
      ];

      # Persisted Files
      user.persist = {
        directories = [
          ".config/autostart"
          ".config/dconf"
          ".config/Mousepad"
          ".config/plank"
          ".config/Thunar"
          ".config/xfce4"
          ".cache/xfce4"
        ];
      };

      # User Configuration
      user.home = {
        # GTK+ Theming
        gtk =
          {
            enable = true;
            gtk3.extraCss = xfce.css;
          }
          // theme;

        # Default Applications
        xdg.mimeApps.defaultApplications = util.build.mime xdg.mime {
          audio = ["org.xfce.Parole.desktop"];
          calendar = ["org.xfce.orage.desktop"];
          directory = ["thunar.desktop"];
          image = ["org.xfce.ristretto.desktop"];
          pdf = ["atril.desktop"];
          text = ["org.xfce.mousepad.desktop"];
          video = ["org.xfce.Parole.desktop"];
        };

        home.file =
          {
            # GTK+ Bookmarks
            ".config/gtk-3.0/bookmarks".text = gtk.bookmarks;

            # Plank Dock
            ".config/autostart/Dock.desktop".text = plank.autostart;
            ".config/plank/dock1/launchers".source = plank.launchers;
            ".local/share/plank/themes/default/dock.theme".text = plank.theme;

            # Desktop Settings
            ".config/xfce4/terminal/terminalrc".text = xfce.terminal;
            ".config/xfce4/panel" = {
              source = xfce.panel;
              recursive = true;
            };
          }
          // mapAttrs' (name: value:
            nameValuePair ".config/xfce4/xfconf/xfce-perchannel-xml/${name}.xml"
            {text = value;})
          files.xfce.settings;

        # Code Editor Settings
        programs.vscode = mkIf (elem pkgs.vscode apps) {
          extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "arc-dark";
              publisher = "alvesvaren";
              version = "0.4.0";
              sha256 = "sha256-DM4sY4NsQdlhF+sLLgYuCrNcdmUBRO5c458GpMhF5xg=";
            }
          ];
          userSettings = {
            "workbench.colorTheme" = "Arc Dark Theme";
            "terminal.external.linuxExec" = "xfce4-terminal";
          };
        };
      };
    })

    # Minimal XFCE Desktop Configuration
    (mkIf (desktop == "xfce-minimal") {
      # Utilities
      environment.systemPackages = [pkgs.firefox];

      # Disabled Services
      services.tumbler.enable = mkForce false;
      services.accounts-daemon.enable = mkForce false;
    })
  ]);
}
