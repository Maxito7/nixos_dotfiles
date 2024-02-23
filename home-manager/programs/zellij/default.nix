{ config
, pkgs
, lib
, libs
, ...
}: {
  home.packages = with pkgs; [
    zjstatus
  ];
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile = {
    "zellij/config.kdl".source = ./config.kdl;
    "zellij/themes/default.kdl".source = ./themes/default.kdl;
    "zellij/layouts/custom.kdl".text = import ./layouts/custom.nix { inherit pkgs lib; };
  };
}
