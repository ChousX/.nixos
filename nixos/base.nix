{outputs, lib, inputs, pkgs, config, ...}:
{
  imports = [
    ./default-user.nix
    ./localization.nix
    ./bluetooth.nix
    ./ssh.nix
    ./zsh.nix
    ./sound.nix
    ./fonts.nix
  ];

  xdg.portal.enable = true;
  networking.networkmanager.enable = true;
  services = {
    printing.enable = true;
    flatpak.enable = true;
  };
  
  nixpkgs= {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.nvimPlugins
    ];
    config.allowUnfree = true;
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  environment.systemPackages = with pkgs; [
    starship
    bat
    git
    ripgrep
    vlc
    alacritty
  ];

  system.stateVersion = "23.11";
}
