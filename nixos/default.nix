{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./default-user.nix
    ./kde.nix
    ./localization.nix
    ./sddm.nix
    ./sound.nix
    ./ssh.nix
    ./zsh.nix
    ./fonts.nix
  ];

  xdg.portal.enable = true;
  networking.networkmanager.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
  };

  nixpkgs = {
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
    bat
    git
    ripgrep
  ];

  system.stateVersion = "23.11";
}
