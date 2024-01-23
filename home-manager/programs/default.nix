{ config
, pkgs
, ...
}: {
  imports = [
    ./neovim
		./ghostty.nix
  ];
}
