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
    ./fonts.nix
  ];

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
      discord
      github-cli
      bat
      ripgrep
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
        bevy-init = "nix flake new --template ~/Templates#rust-bevy . && sh init.sh";
        v = "nvim";
      };
    };
  };


}
