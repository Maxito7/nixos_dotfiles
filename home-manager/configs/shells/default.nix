{ config
, pkgs
, ...
}: {
  imports = [
    ./starship.nix
    ./fish.nix
    ./nushell.nix
  ];
}
