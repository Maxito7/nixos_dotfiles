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
        alias flake_update="cd ~/.config/nixfiles ; nix flake update ; nh os switch --hostname lucky"
           alias project_devenv="nix flake init --template github:cachix/devenv && direnv allow"
           alias ls="eza -l --icons=always --hyperlink -a"
       alias lst="eza -l --icons=always --hyperlink -a -T"

           direnv hook fish | source

      function yy
      	set tmp (mktemp -t "yazi-cwd.XXXXXX")
      	yazi $argv --cwd-file="$tmp"
      	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      		cd -- "$cwd"
      	end
      	rm -f -- "$tmp"
      end
    '';
  };
}
