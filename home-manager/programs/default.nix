{ config
, pkgs
, ...
}: {
  imports = [
    ./neovim
    ./zellij
  ];
}
