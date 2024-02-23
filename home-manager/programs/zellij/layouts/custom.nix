{ inputs
, pkgs
, lib
, ...
}:
# More icons: https://www.nerdfonts.com/cheat-sheet
let
  black = "#1D202F";
  brightBlack = "#414868";
  yellow = "#ECBE7B";

  white = "#C0CAF5";
  brightWhite = "#FFFFFF";

  red = "#F7768E";
  blue = "#7AA2F7";
  green = "#7BD88F";
in
''
  layout {
    pane split_direction="vertical" {
        pane
    }

    pane size=1 borderless=true {
      plugin location="file:${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm" {
        format_left  "{mode} {tabs}"
        format_space ""

        border_enabled  "false"
        border_char     "─"
        border_format   "#[fg=${yellow}]{char}"
        border_position "top"

        hide_frame_for_single_pane "false"

        mode_tab "#[bg=${green},fg=${black}] {name} "
        mode_default_to_mode "normal"

        tab_normal   "#[fg=${blue}] {index} #[fg=${white}] {name} "
        tab_active   "#[bg=${blue},fg=${black}] {index} #[bg=${brightBlack},fg=${white}] {name} "
        tab_separator "  "
      }
    }
  }
''
