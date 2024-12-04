{ config
, pkgs
, ...
}: {
  imports = [
    ./neovim
    ./zellij
    ./yazi
    ./git
  ];
}
