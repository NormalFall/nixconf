{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ssbm-nix = {
      url = "github:NormalFall/ssbm-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      customPkgs = (import ./pkgs pkgs);
    in {

      nixosConfigurations = {

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs customPkgs system; };
          modules = [
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs customPkgs system; };
          modules = [
            ./hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        usb = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs customPkgs system; };
          modules = [
            ./hosts/usb/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

      };
    };
}
