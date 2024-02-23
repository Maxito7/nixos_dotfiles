{
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/a136def4f7256146b32e3625e53dcdf7464165f9";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nur.url = "github:nix-community/nur";
    #nixvim.url = "github:nix-community/nixvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "git+ssh://git@github.com/mitchellh/ghostty";
    };
    wfetch = {
      url = "github:iynaix/wfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs =
    { self
    , nixpkgs
    , #, nixpkgs-unstable
      home-manager
    , ghostty
    , zjstatus
    , ...
    } @ inputs: {
      nixpkgsConfig = {
        overlays = import ./overlays { inherit inputs; };
      };
      nixosConfigurations = {
        lucky = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.lucky = import ./home-manager/home.nix;
              };
            }

            {
              environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
                inputs.wfetch.packages.x86_64-linux.default
                zjstatus.packages.x86_64-linux.default
              ];
            }
          ];
        };
      };
      formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    };
}
