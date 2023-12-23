{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    	set fish_greeting
	# Alias
        alias flake_update="cd ~/.config/nixfiles ; nix flake update ; sudo nixos-rebuild switch --flake .#lucky"
        alias project_devenv="nix flake init --template github:cachix/devenv && direnv allow"
        direnv hook fish | source
    '';
  };
}
