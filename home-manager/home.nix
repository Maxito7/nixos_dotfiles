{ pkgs
, inputs
, ...
}: {
  home.username = "lucky";
  home.homeDirectory = "/home/lucky";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  gtk = {
    cursorTheme = {
      name = "WhiteSur-Cursors";
      package = pkgs.whitesur-cursors;
    };
  };

  imports = [
    ./configs
    ./programs
  ];
}
