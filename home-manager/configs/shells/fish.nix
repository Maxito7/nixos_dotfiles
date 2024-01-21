{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.mkAfter ''
          	set fish_greeting
      	# Alias
              alias flake_update="cd ~/.config/nixfiles ; nix flake update ; sudo nixos-rebuild switch --flake .#lucky"
              alias project_devenv="nix flake init --template github:cachix/devenv && direnv allow"
      				alias ls="eza -l --icons=always --hyperlink -a"

      				function starship_transient_prompt_func
      					starship module_character
      				end
      				enable_transience

              direnv hook fish | source
    '';
  };
}
