{ config
, pkgs
, lib
, libs
, inputs
, ...
}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile = {
    "zellij/config.kdl".source = ./config.kdl;
    "zellij/themes/default.kdl".source = ./themes/default.kdl;
    "zellij/layouts/custom.kdl".text = import ./layouts/custom.nix { inherit inputs pkgs lib; };
  };
}
