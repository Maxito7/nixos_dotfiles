{ inputs
, pkgs
, lib
, ...
}:
# More icons: https://www.nerdfonts.com/cheat-sheet
let
  black = "#121619";
  brightBlack = "#21272a";
  yellow = "#f1c21b";

  white = "#f2f4f8";
  brightWhite = "#FFFFFF";

  purple = "#8a3ffc";
  cyan = "#82cfff";
  orange = "#ff832b";

  red = "#Fa4d56";
  blue = "#4589ff";
  green = "#42be65";
in
''
  layout {
    pane size=1 borderless=true {
      plugin location="file:${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm" {
        format_left  "{mode}"
  			format_center "{tabs}"
  			format_right "#[bg=${blue},fg=${black},bold] {session} "
        format_space "#[bg=${black}]"

        border_enabled  "false"
        border_char     "─"
        border_format   "#[fg=${yellow}]{char}"
        border_position "top"

        hide_frame_for_single_pane "true"

  			mode_normal "#[bg=${blue},fg=${black},bold] {name} "
  			mode_locked "#[bg=${red},fg=${black},bold] {name} "
        mode_tab "#[bg=${green},fg=${black}] {name} "
  			mode_pane "#[bg=${purple},fg=${black}] {name} "
  			mode_session "#[bg=${orange},fg=${black}] {name} "
        mode_default_to_mode "normal"

        tab_normal   "#[bg=${black},fg=${cyan}] {index} #[bg=${black},fg=${white}] {name} "
        tab_active   "#[bg=${cyan},fg=${black}] {index} #[bg=${brightBlack},fg=${white},bold] {name} "
        tab_separator ""
      }
    }
  pane split_direction="vertical" {
        pane
    }
  }
''
