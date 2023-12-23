{
	programs.zsh = {
		enable = true;
		shellAliases = {
			flake_update = "nix flake update";
			flake_switch = "sudo nixos-rebuild switch --flake .#lucky";
		};
		#histSize = 10000;
		#histFile = "~/.config/nixfiles/home-manager/configs/shells/zsh/history";
		zplug = {
			enable = true;
			plugins = [
				{ name = "zsh-users/zsh-autosuggestions"; }
			];
		};
	};
}
