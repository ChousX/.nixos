{ config, outputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.nvimPlugins
  ];

  imports = [./neovim.nix];

  home = { 
    username = "chousx";
    homeDirectory = "/home/chousx";
    stateVersion = "23.11"; # Please read the comment before changing.
    packages = with pkgs; [
      signal-desktop
      open-dyslexic
      fantasque-sans-mono
      firefox
      wezterm
      vlc
      git-credential-manager
    ];
    file = {
      ".emacs.d".source = ./configs/emacs;
      ".config/alacritty".source = ./configs/alacritty;
    };
    sessionVariables = {
      EDITOR = "nvim";
      HOME_MANAGER_FLAKE = "$HOME/.config/home-manager";
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "ChousX";
      userEmail = "gmanenergy@gmail.com";
      extraConfig.credential.helper = "oauth";
      aliases = {
        pu = "push";
	      co = "checkout";
	      cm = "commit -m";
      };
    };

    emacs = {
      enable = true;
      extraConfig = "";
      extraPackages = epkgs: with epkgs; [
        flycheck-eglot
        flycheck
        doom-modeline
        exec-path-from-shell
	      rust-mode
        use-package
	      eglot
	      evil
	      magit
	      company
	      timu-macos-theme
	      general
	      vertico
	      yasnippet
	      treesit-grammars.with-all-grammars
      ];
    };

    alacritty = {
      enable = true;
    };

    rofi = {
      enable = true;
      location = "center";
    };

    starship = {
      enable = true;
    };

    firefox = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch --flake ~/.nixos/.";
        update-home = "home-manager switch --flake ~/.nixos/.";
        bevy-init = "nix flake new --template ~/Templates#rust-bevy .";
        v = "nvim";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = 
      [
        "$mod, E, exec, emacs"
        "$mod, R, exec, rofi -show run"
        "$mod, F, exec, firefox"
        "$mod, Return, exec, alacritty"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, Delete, exec, hyprctl dispatch exit"
        "$mod, A, exec, alacritty"
        #", Print, exec, "
      ]
      ++ (
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
            builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString(x + 1)}"
          ])
          10
        )
      );
    };
  };

}
