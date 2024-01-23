{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NOTE: This will require your git SSH access to the repo.
    #
    # WARNING: Do NOT pin the `nixpkgs` input, as that will
    # declare the cache useless. If you do, you will have
    # to compile LLVM, Zig and Ghostty itself on your machine,
    # which will take a very very long time.
    ghostty = {
      url = "git+ssh://git@github.com/mitchellh/ghostty";
    };
  };

  outputs = { nixpkgs, ghostty, ... }: {
    nixosConfigurations.mysystem = nixpkgs.lib.nixosSystem {
      modules = [
        {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
