{ lib, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      format = ''
        $directory$nodejs$rust$typst$golang$php$c$python$kotlin$java$zig$ruby$gleam$kubernetes$nix_shell$git_branch$git_status
        $character
      '';
      fill = {
        symbol = " ";
      };
      directory = {
        format = "([($path)]($style))";
        style = "bold fg:#5e99ff";

        truncation_length = 2;
        truncation_symbol = " /";
      };

      character = {
        success_symbol = "[](bold fg:#5e99ff)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold green)";
      };

      git_branch = {
        symbol = "";
        style = "bold fg:#5e99ff";
        format = "([( $symbol $branch)]($style))";
      };

      git_status = {
        style = "bold fg:#7aa2f7";
        format = "([( $all_status$ahead_behind)]($style))";
      };

      nodejs = {
        symbol = "";
        style = "bold fg:#62d196";
        format = "([( $symbol ($version))]($style))";
      };

      rust = {
        symbol = "";
        style = "bold fg:#FF9e64";
        format = "([( $symbol ($version))]($style))";
      };

      golang = {
        symbol = "󰟓";
        style = "bold fg:#7dcfff";
        format = "([( $symbol ($version))]($style))";
      };

      php = {
        symbol = "";
        style = "bold fg:#769ff0";
        format = "([( $symbol ($version))]($style))";
      };

      c = {
        symbol = "";
        style = "bold fg:#BB8AF7";
        format = "([( $symbol ($version))]($style))";
      };

      python = {
        symbol = "󰌠";
        style = "bold fg:#6fdc8c";
        format = "([( $symbol ($version))]($style))";
      };

      kotlin = {
        symbol = "";
        style = "bold fg:#bb9af7";
        format = "([( $symbol ($version))]($style))";
      };

      java = {
        symbol = "";
        style = "bold fg:#ff9e64";
        format = "([( $symbol ($version))]($style))";
      };

      zig = {
        symbol = "";
        style = "bold fg:#ff9e64";
        format = "([( $symbol ($version))]($style))";
      };

      ruby = {
        symbol = "";
        style = "bold fg:#f7768e";
        format = "([( $symbol ($version))]($style))";
      };

      gleam = {
        symbol = "";
        style = "bold fg:#ff96f3";
        format = "([( $symbol ($version))]($style))";
      };

      typst = {
        symbol = "";
        style = "bold fg:#6fdcbb";
        format = "([( $symbol ($version))]($style))";
      };

      nix_shell = {
        impure_msg = "[  Impure](bold fg:#a675ff)";
        pure_msg = "[  Pure](bold fg:#5e99ff)";
        format = "$state";
      };
      kubernetes = {
        format = "[󱃾 ($user on )($cluster in )$context \($namespace\)](bold fg: #5e99ff) ";
        disabled = false;
        detect_files = [ "k8s" ];
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
