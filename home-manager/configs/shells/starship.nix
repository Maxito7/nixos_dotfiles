{ lib, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = ''
        [ 󰠖 ](bg:#42be65 bold fg:#121619)[](bg:#4589ff fg:#42be65)$directory[](fg:#4589ff bg:#24283b)$nodejs$rust$golang$php$c$python$kotlin$java$zig[](fg:#24283b bg:#272d40)$nix_shell[](fg:#272d40 bg:#30364a)$git_branch[](fg:#30364a bg:#363c4f)$git_status[](fg:#363c4f)
        $character
      '';
      fill = {
        symbol = " ";
      };
      directory = {
        format = "([( $path )]($style))";
        style = "bg:#4589ff bold fg:#1a1b26";

        truncation_length = 1;
        truncation_symbol = " /";
      };

      character = {
        success_symbol = "[](bold fg:#33b1ff)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold green)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#30364a bold fg:#0f62fe";
        format = "([( $symbol $branch )]($style))";
      };

      git_status = {
        style = "bg:#363c4f bold fg:#4589ff";
        format = "([( $all_status$ahead_behind )]($style))";
      };

      nodejs = {
        symbol = "";
        style = "bg:#24283b bold fg:#42be65";
        format = "([( $symbol ($version) )]($style))";
      };

      rust = {
        symbol = "";
        style = "bg:#24283b bold fg:#FF832b";
        format = "([( $symbol ($version) )]($style))";
      };

      golang = {
        symbol = "󰟓";
        style = "bg:#24283b bold fg:#33b1ff";
        format = "([( $symbol ($version) )]($style))";
      };

      php = {
        symbol = "";
        style = "bg:#24283b bold fg:#769ff0";
        format = "([( $symbol ($version) )]($style))";
      };

      c = {
        symbol = "";
        style = "bg:#24283b bold fg:#6929c4";
        format = "([( $symbol ($version) )]($style))";
      };

      python = {
        symbol = "󰌠";
        style = "bg:#24283b bold fg:#6fdc8c";
        format = "([( $symbol ($version) )]($style))";
      };

      kotlin = {
        symbol = "";
        style = "bg:#24283b bold fg:#bb9af7";
        format = "([( $symbol ($version) )]($style))";
      };

      java = {
        symbol = "";
        style = "bg:#24283b bold fg:#ff832b";
        format = "([( $symbol ($version) )]($style))";
      };

      zig = {
        symbol = "";
        style = "bg:#24283b bold fg:#ff832b";
        format = "([( $symbol ($version) )]($style))";
      };

      nix_shell = {
        impure_msg = "[  Impure ](bg:#272d40 bold fg:#8a3ffc)";
        pure_msg = "[  Pure ](bg:#272d40 bold fg:#0f62fe)";
        format = "$state";
      };
    };
  };

  # add transient prompt for fish
  programs.fish.interactiveShellInit = lib.mkAfter ''
    function starship_transient_prompt_func
      starship module character
    end
    enable_transience
  '';
}
