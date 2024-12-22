{
  description = "From Nothing. I Hope this is my last os flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    #nixtheplanet.url = "github:matthewcroughan/nixtheplanet";
    stylix.url = "github:danth/stylix";

    #optimize settings for different hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {self, home-manager, nixpkgs, nixos-hardware, ...}@inputs:
  let 
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        # "i686-linux"
        "x86_64-linux"
        # "aarch64-darwin"
        # "x86_64-darwin"
      ];
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    nixosConfigurations = with nixpkgs.lib; {
      desktop = nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ 
          ./hosts/desktop 
          ./hosts/modules
          inputs.stylix.nixosModules.stylix
        ];
      };
      #laptop = nixosSystem {
        #specialArgs = { inherit inputs outputs; };
        #modules = [ ./hosts/laptop ];
      #};
    };
    homeConfigurations = {
      "chousx@base-camp" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
        extraSpecialArgs = { inherit inputs outputs;};
        modules = [
          ./homes/chousx/base-camp.nix 
          nixos-hardware.nixosModules.dell-xps-15-9550
        ];
      };
    };
  };
}
