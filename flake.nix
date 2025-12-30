{
  description = "NixOS/Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, ... }:
    let
      user = "levenrok";
    in
    {
      nixosConfigurations = {
        levens-desktop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit user nixpkgs-unstable; };
            modules = [
              ({ config, ... }: {
                nixpkgs.overlays = [
                  (final: prev: {
                    unstable = import nixpkgs-unstable {
                      system = prev.system;
                      config.allowUnfree = true;
                    };
                  })
                ];
              })
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
      } //
      flake-utils.lib.eachDefaultSystem (system: {
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
    };
}
