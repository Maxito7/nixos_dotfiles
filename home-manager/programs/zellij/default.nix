{ config
, pkgs
, libs
, ...
}: {
  home.packages = with pkgs; [
    zjstatus
  ];
  programs.zellij = {
    enable = true;
  };

  # Copy Zellij config, until it is properly supported by HM
  xdg.configFile."zellij/config.kdl".source = ../configs/zellij/config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".text = ''    layout {
    		default_tab_template {
    			children
    			pane size=1 borderless=true {
    				plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
    					hide_frame_for_single_pane "true"

    					format_left "{mode} #[fg=#89B4FA,bg=#181825,bold]{session}#[bg=#181825] {tabs}"
    					format_space "#[bg="181825]"

    					mode_normal "#[bg=#89B4FA] "
    					mode_tmux "#[bg=#FFC387] "
    					mode_default_to_mode "tmux"

    					tab_normal "#[fg=#6C7086,bg=#181825] {index} {name} "
    					tab_actove "#[fg=#9399B2,bg=#181825,bold,italic] {italic} {name} "
    				}
    			}
    		}
    	}
  '';
}
