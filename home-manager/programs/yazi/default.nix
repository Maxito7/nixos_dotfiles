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
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz.override { useUasm = true; };
    };
  };
  xdg.configFile = {
    "yazi/yazi.toml".source = ./yazi.toml;
    "yazi/init.lua".source = ./init.lua;
    #"yazi/plugins/glow.yazi/".source = ./plugins/glow.yazi;
    #"yazi/plugins/starship.yazi/".source = ./plugins/starship.yazi;
    "yazi/plugins/full-border.yazi/".source = ./plugins/full-border.yazi;
  };
}
