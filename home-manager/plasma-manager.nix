{ pkgs, ... }:

{
<<<<<<< HEAD
=======

>>>>>>> 8692dc5db11ca8d4177a7d00360c47115cdcf4f7
  programs.plasma = {

    # Some high-level settings:
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor.theme = "Bibata-Modern-Ice";
      iconTheme = "Papirus-Dark";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    };

    hotkeys.commands."launch-wezterm" = {
      name = "Launch WezTerm";
      key = "Meta+Enter";
      command = "wezterm";
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
      # Global menu at the top
      {
        location = "top";
        height = 26;
        widgets = [
          "org.kde.plasma.appmenu"
        ];
      }
    ];


    #
    # Some mid-level settings:
    #
    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Screensaver" "Meta+Shift+Delete" ];
      };

      kwin = {
        "Expose" = "Meta+,";
        #"Switch Window Down" = "Meta+J";
        "Switch Window Down" = "Meta+Down";
        #"Switch Window Left" = "Meta+H";
        "Switch Window Left" = "Meta+Left";
        #"Switch Window Right" = "Meta+L";
        "Switch Window Right" = "Meta+Right";
        #"Switch Window Up" = "Meta+K";
        "Switch Window Up" = "Meta+Up";
      };
    };


    #
    # Some low-level settings:
    #
    #configFile = {
      #"baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      #"kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
      #"kwinrc"."Desktops"."Number" = {
        #value = 8;
        ## Forces kde to not change this value (even through the settings app).
        #immutable = true;
      #};
    #};
  };
}
