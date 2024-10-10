{ config, outputs, pkgs, ... }:
{
  nixpkgs = {
    overlays =  [
      outputs.overlays.nvimPlugins
    ];
    config.allowUnfree = true;
  };

  imports = [
    ./neovim.nix
    ./hyperland.nix
    ./firefox.nix
    ./plasma-manager.nix
  ];

  home = { 
    username = "chousx";
    homeDirectory = "/home/chousx";
    stateVersion = "23.11"; # Please read the comment before changing.
    packages = with pkgs; [
      signal-desktop
      vlc
      git-credential-manager
      discord
      vesktop
      github-cli
      bat
      ripgrep
      dust
      tldr
      aseprite
      unrar
      alacritty
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


  services.ssh-agent.enable = true;

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
	      cm = "commit -a -m";
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

    rofi = {
      enable = true;
      location = "center";
      cycle = true;
      plugins = [
          pkgs.rofi-calc
          pkgs.rofi-emoji
          pkgs.rofi-systemd
        ];
    };

    starship = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
        strategy = ["completion"];
      };
      autocd = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        bevy-init = "nix flake new --template ~/Templates#rust-bevy . && sh init.sh";
        v = "nvim";
        ip = "ip --color=auto";
      };
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = false;
      enableBashIntegration = false;
    };

    ranger = {
      enable = true;
    };
  };


}
