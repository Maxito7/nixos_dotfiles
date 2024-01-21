{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = ''
        [ 󰠖 ](bg:#7bd88f bold fg:#1a1b26)[](bg:#7aa2f6 fg:#7bd88f)$directory[](fg:#7aa2f6 bg:#24283b)$nodejs$rust$golang$php$c$python$kotlin$java$zig[](fg:#24283b bg:#272d40)$nix_shell[](fg:#272d40 bg:#30364a)$git_branch[](fg:#30364a bg:#363c4f)$git_status[](fg:#363c4f)
        $character
      '';
      fill = {
        symbol = " ";
      };
      directory = {
        format = "([( $path )]($style))";
        style = "bg:#7aa2f6 bold fg:#1a1b26";

        truncation_length = 1;
        truncation_symbol = " /";
      };

      character = {
        success_symbol = "[](bold fg:#7aa2f7)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold green)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#30364a bold fg:#7aa2f7";
        format = "([( $symbol $branch )]($style))";
      };

      git_status = {
        style = "bg:#363c4f bold fg:#769ff0";
        format = "([( $all_status$ahead_behind )]($style))";
      };

      nodejs = {
        symbol = "";
        style = "bg:#24283b bold fg:#7BD88F";
        format = "([( $symbol ($version) )]($style))";
      };

      rust = {
        symbol = "";
        style = "bg:#24283b bold fg:#FF9E64";
        format = "([( $symbol ($version) )]($style))";
      };

      golang = {
        symbol = "󰟓";
        style = "bg:#24283b bold fg:#7dcfff";
        format = "([( $symbol ($version) )]($style))";
      };

      php = {
        symbol = "";
        style = "bg:#24283b bold fg:#769ff0";
        format = "([( $symbol ($version) )]($style))";
      };

      c = {
        symbol = "";
        style = "bg:#24283b bold fg:#BB9AF7";
        format = "([( $symbol ($version) )]($style))";
      };

      python = {
        symbol = "󰌠";
        style = "bg:#24283b bold fg:#7bd88f";
        format = "([( $symbol ($version) )]($style))";
      };

      kotlin = {
        symbol = "";
        style = "bg:#24283b bold fg:#bb9af7";
        format = "([( $symbol ($version) )]($style))";
      };

      java = {
        symbol = "";
        style = "bg:#24283b bold fg:#ff9e64";
        format = "([( $symbol ($version) )]($style))";
      };

      zig = {
        symbol = "";
        style = "bg:#24283b bold fg:#ff9e64";
        format = "([( $symbol ($version) )]($style))";
      };

      nix_shell = {
        impure_msg = "[  Impure ](bg:#272d40 bold fg:#bb9af7)";
        pure_msg = "[  Pure ](bg:#272d40 bold fg:#769ff0)";
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
