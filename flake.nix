{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nur.url = "github:nix-community/NUR";
    #nixvim.url = "github:nix-community/nixvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		ghostty = {
      url = "git+ssh://git@github.com/mitchellh/ghostty";
    };		
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
		ghostty,
    #nixvim,
    ...
  } @ inputs: {
    /* 
      homeConfigurations = 
        let
          overlays = [
            inputs.neovim-nightly-overlay.overlay
          ];
        in {
        #macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = overlays;
            };
        #};
      };
    */
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
          ];
        }
        ];
      };
    };
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
  };
}
