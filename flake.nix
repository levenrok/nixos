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
    in
    {
      nixosConfigurations = {
        levens-desktop = nixpkgs.lib.nixosSystem {
          system = desktop-system;
          modules = [
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = nixpkgs-unstable.legacyPackages.${prev.system};
                })
              ];
            }
            ./system/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./system/desktop/home-manager/home.nix;
                backupFileExtension = "backup";
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
