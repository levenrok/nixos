{
  description = "NixOS/Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      user = "levenrok";

      desktop-system = "x86_64-linux";

      pkgs = system: nixpkgs.legacyPackages.${system};
      pkgs-unstable = system: nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        levens-desktop = nixpkgs.lib.nixosSystem {
          system = desktop-system;
          specialArgs = {
            pkgs-unstable = pkgs-unstable desktop-system;
          };
          modules = [
            ./system/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./system/desktop/home-manager/home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  pkgs-unstable = pkgs-unstable desktop-system;
                };
              };
            }
          ];
        };
      };

      formatter = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
        system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
