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

  purple = "#bb9af7";
  cyan = "#7dcfff";
  orange = "#ff9e64";

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
  pane
  }
''
