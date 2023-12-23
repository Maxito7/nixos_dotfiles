{
	programs.zsh = {
		enable = false;
		syntaxHighlighting.enavle = true;
		enableAutosuggestions = true;
		history.path = "/home/lucky/.config/zsh/zsh_history";
		shellAliases = {
			flake_update = "nix flake update";
			flake_switch = "sudo nixos-rebuild switch --flake .#lucky";
			giti = "git init";
			gita = "git add .";
			gitc = "git commit -m";
			gitp = "git push";
			gitrao = "git remote add origin";
			gitbm = "git branch -M";
			gitpuo = "git push -u origin";
			gitrso = "git remote set-url origin";
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
