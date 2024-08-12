{ config
, pkgs
, lib
, libs
, inputs
, ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile = {
    "yazi/yazi.toml".source = ./yazi.toml;
  };
}
