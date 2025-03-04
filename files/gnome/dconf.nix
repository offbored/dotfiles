{
  config,
  sys,
  lib,
  files,
  ...
}:
with lib.hm.gvariant; let
  homeDir = config.home.homeDirectory;
  android = sys.hardware.vm.android.enable;
in {
  # Home Directory
  home.file = {
    # Wallpapers
    ".local/share/backgrounds".source = files.images.wallpapers;

    # GTK+ Bookmarks
    ".config/gtk-3.0/bookmarks".text = lib.mkBefore ''
      file://${homeDir}/Documents/TBD TBD
    '';
  };

  ## Dconf Keys ##
  # Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
  dconf.settings = {
    # Keyboard Shortcuts
    "org/gnome/desktop/wm/keybindings" = {
      begin-move = [];
      begin-resize = [];
      close = ["<Super>q" "<Alt>F4"];
      cycle-group = [];
      cycle-group-backward = [];
      maximize = ["<Super>Up"];
      minimize = ["<Super>Down"];
      move-to-monitor-down = [];
      move-to-monitor-left = ["<Shift><Super>Left"];
      move-to-monitor-right = ["<Shift><Super>Right"];
      move-to-monitor-up = [];
      move-to-workspace-1 = [];
      move-to-workspace-down = [];
      move-to-workspace-last = [];
      move-to-workspace-left = ["<Primary><Super>Left"];
      move-to-workspace-right = ["<Primary><Super>Right"];
      move-to-workspace-up = [];
      panel-main-menu = [];
      panel-run-dialog = ["<Super>F2"];
      switch-applications = ["<Alt>Tab"];
      switch-applications-backward = ["<Shift><Alt>Tab"];
      switch-group = ["<Super>Tab"];
      switch-group-backward = ["<Shift><Super>Tab"];
      switch-to-workspace-down = ["<Primary><Super>Down" "<Primary><Super>j"];
      switch-to-workspace-left = ["<Super>Left"];
      switch-to-workspace-right = ["<Super>Right"];
      switch-to-workspace-up = ["<Primary><Super>Up" "<Primary><Super>k"];
      toggle-maximized = ["<Super>m"];
      unmaximize = [];
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      open-application-menu = [];
      toggle-message-tray = [];
      toggle-overview = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      area-screenshot = ["Print"];
      area-screenshot-clip = [];
      control-center = ["<Super>i"];
      email = ["<Super>e"];
      home = ["<Super>f"];
      magnifier = ["<Super>x"];
      magnifier-zoom-in = ["<Super>equal"];
      magnifier-zoom-out = ["<Super>minus"];
      rotate-video-lock-static = [];
      screencast = ["<Alt>Print"];
      screenreader = [];
      screenshot = ["<Shift>Print"];
      screenshot-clip = [];
      screensaver = ["<Super>l"];
      terminal = ["<Super>t"];
      volume-down = ["AudioLowerVolume"];
      volume-up = ["AudioRaiseVolume"];
      window-screenshot = ["<Primary>Print"];
      window-screenshot-clip = [];
      www = ["<Super>w"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Primary><Alt>Return";
      command = "gnome-system-monitor";
      name = "Task Manager";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>t";
      command = "kgx";
      name = "Terminal";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      titlebar-font = "Product Sans Bold 11";
      visual-bell = false;
      num-workspaces = 4;
      workspace-names = ["Home" "School" "Work" "Play"];
    };

    # Core Settings
    "org/gnome/desktop/a11y".always-show-universal-access-status = true;
    "org/gnome/desktop/a11y/applications".screen-magnifier-enabled = false;

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      center-new-windows = true;
      dynamic-workspaces = false;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      document-font-name = "Product Sans 11";
      enable-animations = true;
      enable-hot-corners = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Product Sans Medium, Medium 11";
      gtk-im-module = "gtk-im-context-simple";
      locate-pointer = true;
      monospace-font-name = "MesloLGS NF 10";
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 1800;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 19.0;
      night-light-schedule-to = 7.0;
      night-light-temperature = "uint32 3700";
    };

    "org/gnome/desktop/a11y/magnifier" = {
      cross-hairs-clip = true;
      cross-hairs-color = "#15519a";
      cross-hairs-length = 1440;
      cross-hairs-opacity = 1.0;
      mouse-tracking = "proportional";
      show-cross-hairs = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
      old-files-age = "uint32 7";
      remember-recent-files = false;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      event-sounds = true;
      theme-name = "freedesktop";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      lock-delay = "uint32 0";
      lock-enabled = false;
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    # GTK+ Apps
    "org/gnome/desktop/calendar".show-weekdate = true;
    "ca/desrt/dconf-editor".show-warning = false;
    "io/github/seadve/Kooha".video-format = "mp4";
    "org/gnome/boxes".shared-folders = "[<{'uuid': <'5b825243-4232-4426-9d82-3df05e684e42'>, 'path': <'${homeDir}'>, 'name': <'Home'>}>]";
    "org/gnome/shell/world-clocks".locations = "[<(uint32 2, <('Coordinated Universal Time (UTC)', '@UTC', false, @a(dd) [], @a(dd) [])>)>]";

    "org/gnome/Geary" = {
      ask-open-attachment = true;
      compose-as-html = true;
      formatting-toolbar-visible = false;
      migrated-config = true;
      optional-plugins = ["email-templates" "sent-sound" "mail-merge"];
      startup-notifications = true;
    };

    "org/gnome/epiphany" = {
      active-clear-data-items = 391;
      ask-for-default = false;
      default-search-engine = "Google";
      restore-session-policy = "crashed";
      use-google-search-suggestions = true;
    };

    "org/gnome/epiphany/sync".sync-device-name = sys.networking.hostName;
    "org/gnome/epiphany/web" = {
      default-zoom-level = 1.0;
      enable-mouse-gestures = true;
    };

    "org/gtk/gtk4/settings/file-chooser".sort-directories-first = true;
    "org/gnome/nautilus/icon-view" = {
      captions = ["size" "date_modified" "none"];
      default-zoom-level = "medium";
    };

    "org/gnome/nautilus/preferences" = {
      click-policy = "single";
      default-folder-viewer = "icon-view";
      fts-enabled = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };

    "org/gnome/TextEditor" = {
      highlight-current-line = true;
      indent-style = "tab";
      show-line-numbers = true;
      show-map = true;
      tab-width = mkUint32 4;
    };

    "com/github/hugolabe/Wike" = {
      custom-font = true;
      dark-mode = true;
      font-family = "Product Sans";
    };

    "org/gnome/builder/editor" = {
      auto-hide-map = true;
      auto-save-timeout = 60;
      completion-n-rows = 7;
      draw-spaces = ["tab"];
      highlight-current-line = true;
      highlight-matching-brackets = true;
      overscroll = 7;
      show-map = false;
      style-scheme-name = "builder-dark";
    };

    "org/gnome/gnome-screenshot" = {
      delay = 0;
      include-pointer = true;
      last-save-directory = "file://${homeDir}/Pictures/Screenshots";
    };

    # App Grid
    "org/gnome/shell" = {
      command-history = ["rt" "r"];
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      disabled-extensions = ["workspace-indicator@gnome-shell-extensions.gcampax.github.com"];
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "CoverflowAltTab@palatis.blogspot.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "flypie@schneegans.github.com"
        "gestureImprovements@gestures"
        "gnome-ui-tune@itstime.tech"
        "gTile@vibou"
        "guillotine@fopdoodle.net"
        "just-perfection-desktop@just-perfection"
        "lock-screen-message@advendradeswanta.gitlab.com"
        "lockkeys@vaina.lt"
        "pano@elhan.io"
        "quick-settings-avatar@d-go"
        "quick-settings-tweaks@qwreey"
        "rounded-window-corners@yilozt"
        "space-bar@luchrioh"
        "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
        "timepp@zagortenay333"
        "top-bar-organizer@julian.gse.jsts.xyz"
        "transparent-top-bar@ftpix.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "weatheroclock@CleoMenezesJr.github.io"
      ];
      favorite-apps = [
        "google-chrome.desktop"
        "org.gnome.Geary.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.TextEditor.desktop"
        "org.gnome.Settings.desktop"
      ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children =
        [
          "1c3e59e4-a571-4ada-af1d-ed1ced384cfb"
          "4f9e09f6-cbd8-4a4a-beb3-9ec7b3e672ff"
          "a136187d-1d93-4d35-8423-082f15957be9"
          "b79e9b82-2127-459b-9e82-11bd3be09d04"
        ]
        ++ lib.optionals android ["cb1c8797-b52e-4df5-80d6-2c46e8f7ef22"];
    };

    "org/gnome/desktop/app-folders/folders/4f9e09f6-cbd8-4a4a-beb3-9ec7b3e672ff" = {
      name = "Games";
      apps = [
        "org.gnome.Chess.desktop"
        "org.gnome.Sudoku.desktop"
        "org.gnome.Mines.desktop"
        "org.gnome.Quadrapassel.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/a136187d-1d93-4d35-8423-082f15957be9" = {
      name = "Office";
      apps = [
        "Code.desktop"
        "startcenter.desktop"
        "writer.desktop"
        "impress.desktop"
        "draw.desktop"
        "base.desktop"
        "calc.desktop"
        "math.desktop"
        "onlyoffice-desktopeditors.desktop"
        "net.sourceforge.gscan2pdf.desktop"
        "virt-manager.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/b79e9b82-2127-459b-9e82-11bd3be09d04" = {
      name = "Utilities";
      apps = [
        "org.gnome.Logs.desktop"
        "org.gnome.Devhelp.desktop"
        "org.gnome.Tour.desktop"
        "cups.desktop"
        "nixos-manual.desktop"
        "yelp.desktop"
        "org.gnome.baobab.desktop"
        "xterm.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/1c3e59e4-a571-4ada-af1d-ed1ced384cfb" = {
      name = "Wine";
      apps = [
        "7zip.desktop"
        "Notepad++.desktop"
        "playonlinux.desktop"
        "net.lutris.Lutris.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/cb1c8797-b52e-4df5-80d6-2c46e8f7ef22" = {
      apps = [
        "waydroid.com.android.inputmethod.latin.desktop"
        "waydroid.org.lineageos.jelly.desktop"
        "waydroid.com.android.calculator2.desktop"
        "waydroid.org.lineageos.etar.desktop"
        "waydroid.com.android.camera2.desktop"
        "waydroid.com.android.deskclock.desktop"
        "waydroid.com.android.contacts.desktop"
        "waydroid.com.android.documentsui.desktop"
        "waydroid.com.android.gallery3d.desktop"
        "waydroid.com.android.vending.desktop"
        "waydroid.org.lineageos.eleven.desktop"
        "waydroid.org.lineageos.recorder.desktop"
        "waydroid.com.android.settings.desktop"
        "Waydroid.desktop"
      ];
      name = "Android";
      translate = false;
    };

    # Shell Extensions
    "org/gnome/shell/extensions/user-theme".name = "Adwaita";
    "org/gnome/shell/extensions/alphabetical-app-grid".folder-order-position = "start";
    "org/gnome/shell/extensions/gestureImprovements".allow-minimize-window = true;
    "org/gnome/shell/extensions/gnome-ui-tune".hide-search = false;
    "org/gnome/shell/extensions/lockkeys".style = "show-hide";
    "org/gnome/shell/extensions/lock-screen-message".message = "Welcome, ${config.credentials.fullname}!";
    "org/gnome/shell/extensions/status-area-horizontal-spacing".hpadding = 4;
    "com/ftpix/transparentbar".transparency = 0;

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position = 0;
      inhibit-apps = ["teams.desktop" "startcenter.desktop"];
      nightlight-control = "never";
      show-indicator = "always";
      show-notifications = false;
    };

    "org/gnome/shell/extensions/coverflowalttab" = {
      animation-time = 0.256;
      easing-function = "ease-in-sine";
      hide-panel = false;
      icon-has-shadow = false;
      icon-style = "Overlay";
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/misc" = {
      ws-switch-wrap = true;
      ws-switch-ignore-last = true;
      ws-switch-indicator-mode = 1;
      show-osd-monitor-indexes = false;
    };

    "org/gnome/shell/extensions/gtile" = {
      show-icon = true;
      target-presets-to-monitor-of-mouse = true;
      theme = "Minimal Dark";
      window-margin = 2;
      window-margin-fullscreen-enabled = true;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = true;
      aggregate-menu = true;
      animation = 4;
      app-menu-icon = false;
      hot-corner = false;
      notification-banner-position = 2;
      show-prefs-intro = false;
      workspace-switcher-should-show = true;
      workspace-background-corner-size = 58;
      workspace-switcher-size = 7;
      workspace-wrap-around = true;
    };

    "org/gnome/shell/extensions/pano" = {
      database-location = "${homeDir}/.local/share/clipboard";
      global-shortcut = ["<Super>v"];
      history-length = 250;
      incognito-shortcut = ["<Ctrl><Super>v"];
      play-audio-on-copy = false;
      send-notification-on-copy = false;
    };

    "org/gnome/shell/extensions/quick-settings-avatar" = {
      avatar-position = 1;
      avatar-realname = false;
      avatar-size = 56;
    };

    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      add-dnd-quick-toggle-enabled = false;
      add-unsafe-quick-toggle-enabled = false;
      datemenu-remove-notifications = false;
      media-control-compact-mode = true;
      media-control-enabled = true;
      notifications-enabled = false;
      volume-mixer-enabled = false;
      volume-mixer-position = "bottom";
    };

    "org/gnome/shell/extensions/rounded-window-corners" = {
      custom-rounded-corner-settings = "@a{sv} {}";
      focused-shadow = "{'vertical_offset': 4, 'horizontal_offset': 0, 'blur_offset': 28, 'spread_radius': 4, 'opacity': 60}";
      global-rounded-corner-settings = "{'padding': <{'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keep_rounded_corners': <{'maximized': <true>, 'fullscreen': <false>}>, 'border_radius': <uint32 12>, 'smoothing': <uint32 0>, 'enabled': <true>}";
      settings-version = mkUint32 5;
      skip-libhandy-app = true;
      unfocused-shadow = "{'horizontal_offset': 0, 'vertical_offset': 2, 'blur_offset': 12, 'spread_radius': -1, 'opacity': 65}";
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      scroll-wheel = "disabled";
      show-empty-workspaces = true;
      smart-workspace-names = true;
    };

    "org/gnome/shell/extensions/timepp" = {
      alarms-separate-menu = false;
      panel-item-position = "Left";
      pomodoro-panel-mode = "Dynamic";
      pomodoro-show-seconds = true;
      stopwatch-panel-mode = "Dynamic";
      timer-panel-mode = "Dynamic";
      timer-show-seconds = true;
      todo-panel-mode = "Icon";
      todo-separate-menu = true;
      unicon-mode = true;
    };

    "org/gnome/shell/extensions/top-bar-organizer" = {
      center-box-order = ["dateMenu"];
      left-box-order = ["Space Bar" "activities" "timepp" "guillotine" "appMenu"];
      right-box-order = [
        "a11y"
        "aggregateMenu"
        "drive-menu"
        "GTileStatusButton"
        "pano@elhan.io"
        "vitalsMenu"
        "dwellClick"
        "lockkeys"
        "keyboard"
        "screenSharing"
        "screenRecording"
        "quickSettings"
      ];
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = ["_default_icon_"];
      show-battery = true;
      show-storage = false;
    };

    "org/gnome/shell/extensions/flypie" = {
      active-stack-child = "settings-page";
      background-color = "rgba(0, 0, 0, 0.26)";
      center-auto-color-luminance = 0.8;
      center-auto-color-luminance-hover = 0.8;
      center-auto-color-opacity = 0.0;
      center-auto-color-opacity-hover = 0.0;
      center-auto-color-saturation = 0.75;
      center-auto-color-saturation-hover = 0.75;
      center-background-image = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      center-background-image-hover = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      center-color-mode = "fixed";
      center-color-mode-hover = "fixed";
      center-fixed-color = "rgba(255,255,255,0)";
      center-fixed-color-hover = "rgba(255,255,255,0)";
      center-icon-crop = 0.8;
      center-icon-crop-hover = 0.8;
      center-icon-opacity = 0.17;
      center-icon-opacity-hover = 1.0;
      center-icon-scale = 0.7;
      center-icon-scale-hover = 0.7;
      center-size = 110.0;
      center-size-hover = 90.0;
      child-auto-color-luminance = 0.7;
      child-auto-color-luminance-hover = 0.8802816901408451;
      child-auto-color-opacity = 1.0;
      child-auto-color-opacity-hover = 1.0;
      child-auto-color-saturation = 0.9;
      child-auto-color-saturation-hover = 1.0;
      child-background-image = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      child-background-image-hover = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      child-color-mode = "fixed";
      child-color-mode-hover = "fixed";
      child-draw-above = false;
      child-fixed-color = "rgba(255,255,255,0)";
      child-fixed-color-hover = "rgba(255,255,255,0)";
      child-icon-crop = 0.8;
      child-icon-crop-hover = 0.8;
      child-icon-opacity = 1.0;
      child-icon-opacity-hover = 1.0;
      child-icon-scale = 0.7;
      child-icon-scale-hover = 0.7;
      child-offset = 106.0;
      child-offset-hover = 113.0;
      child-size = 59.0;
      child-size-hover = 77.0;
      easing-duration = 0.25;
      easing-mode = "ease-out";
      font = "Product Sans Medium, Medium 11";
      grandchild-background-image = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      grandchild-background-image-hover = "/run/current-system/sw/share/gnome-shell/extensions/flypie@schneegans.github.com/presets/assets/adwaita-dark.svg";
      grandchild-color-mode = "fixed";
      grandchild-color-mode-hover = "fixed";
      grandchild-draw-above = false;
      grandchild-fixed-color = "rgba(189,184,178,0)";
      grandchild-fixed-color-hover = "rgba(189,184,178,0)";
      grandchild-offset = 25.0;
      grandchild-offset-hover = 31.0;
      grandchild-size = 17.0;
      grandchild-size-hover = 27.0;
      menu-configuration = ''
        [{"name":"Navigation","icon":"application-menu","shortcut":"F9","centered":false,"id":0,"children":[{"name":"Sound","icon":"audio-speakers","children":[{"name":"Mute","icon":"discord-tray-muted","type":"Shortcut","data":"AudioMute","angle":-1},{"name":"Play / Pause","icon":"exaile-play","type":"Shortcut","data":"AudioPlay","angle":-1},{"name":"Next","icon":"go-next-symbolic","type":"Shortcut","data":"AudioNext","angle":90},{"name":"Previous","icon":"go-next-symbolic-rtl","type":"Shortcut","data":"AudioPrev","angle":270}],"type":"CustomMenu","data":{},"angle":-1},{"name":"Menu","type":"Command","icon":"gnome-menu","data":{"command":"gnome-extensions prefs flypie@schneegans.github.com"},"angle":-1},{"name":"Tasks","type":"Command","icon":"gnome-system-monitor","data":{"command":"gnome-system-monitor"},"angle":-1},{"name":"System","type":"System","icon":"system-log-out","angle":-1,"data":{}},{"name":"Previous","icon":"go-previous","type":"Shortcut","data":{"shortcut":"<Super>Left"},"angle":270},{"name":"Close","icon":"window-close","type":"Shortcut","data":"<Alt>F4","angle":-1},{"name":"Switcher","icon":"preferences-system-windows","type":"RunningApps","data":{"activeWorkspaceOnly":false,"appGrouping":true,"hoverPeeking":true,"nameRegex":""},"angle":-1},{"name":"Favorites","icon":"emblem-favorite","type":"Favorites","data":{},"angle":-1},{"name":"Maximize","icon":"view-fullscreen","type":"Shortcut","data":{"shortcut":"<Super>Up"},"angle":-1},{"name":"Next","icon":"go-next","type":"Shortcut","data":{"shortcut":"<Super>Right"},"angle":-1}],"type":"CustomMenu","data":{}}]'';
      preview-on-right-side = true;
      stashed-items = "[ ]";
      stats-abortions = mkUint32 38;
      stats-added-items = mkUint32 6;
      stats-click-selections-depth1 = mkUint32 15;
      stats-click-selections-depth2 = mkUint32 8;
      stats-click-selections-depth3 = mkUint32 7;
      stats-dbus-menus = mkUint32 24;
      stats-gesture-selections-depth1 = mkUint32 5;
      stats-gesture-selections-depth2 = mkUint32 3;
      stats-gesture-selections-depth3 = mkUint32 1;
      stats-preview-menus = mkUint32 19;
      stats-selections = mkUint32 39;
      stats-selections-1000ms-depth1 = mkUint32 6;
      stats-selections-2000ms-depth2 = mkUint32 1;
      stats-selections-3000ms-depth3 = mkUint32 1;
      stats-selections-750ms-depth1 = mkUint32 5;
      stats-settings-opened = mkUint32 13;
      stats-sponsors-viewed = mkUint32 1;
      stats-tutorial-menus = mkUint32 6;
      stats-unread-achievements = mkUint32 0;
      text-color = "rgb(222,222,222)";
      trace-color = "rgba(0,0,0,0.462838)";
      trace-min-length = 200.0;
      trace-thickness = 8.0;
      wedge-color = "rgba(0,0,0,0.129992)";
      wedge-color-hover = "rgba(0,0,0,0.0747331)";
      wedge-inner-radius = 43.0;
      wedge-separator-color = "rgba(255, 255, 255, 0.13)";
      wedge-separator-width = 1.0;
      wedge-width = 300.0;
    };
  };
}
