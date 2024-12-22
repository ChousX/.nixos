{inputs, config, lib, outputs, ...}: with lib; {
  options.m.basic_system.enable = mkEnableOption "the basic system stuff I always want";
  config = mkIf config.m.basic_system.enable {
    services.flatpak.enable = true;
    home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
    };
    nixpkgs = {
      config.allowUnfree = true;
    };
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        trusted-users = [
          "root"
          "chousx"
        ]; # Set users that are allowed to use the flake command
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      optimise.automatic = true;
      registry = (lib.mapAttrs (_: flake: { inherit flake; }))
        ((lib.filterAttrs (_: lib.isType "flake")) inputs);
      #nixPath = [ "/etc/nix/." ];
    };
    system.stateVersion = "25.05";
  };
}
