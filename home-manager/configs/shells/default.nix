{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./starship.nix
    ./fish.nix
		#./zsh.nix
  ];
}
