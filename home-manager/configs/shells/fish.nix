{ config
, lib
, pkgs
, ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
         set fish_greeting
         function postexec_newline --on-event fish_postexec
           echo ""
         end
         # Alias
      alias flake_update="cd ~/.config/nixfiles ; nix flake update ; nh os switch -- --nom --hostname lucky"
         alias project_devenv="nix flake init --template github:cachix/devenv && direnv allow"
         alias ls="eza -l --icons=always --hyperlink -a"

         direnv hook fish | source
    '';
  };
}
