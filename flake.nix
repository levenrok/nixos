{
  description = "NixOS/Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      user = "levenrok";
    in
    {
      nixosConfigurations = {
        levens-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
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
