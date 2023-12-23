{pkgs, inputs, ...}:
{
   
  programs.neovim = 
	let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
	{
    enable = true; 
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim; 
   
    extraLuaPackages = ps: [ ps.magick ];
    extraLuaConfig = ''
    	${builtins.readFile ./nvim/options.lua}
			${builtins.readFile ./nvim/plugins/other.lua}
    '';

		extraPackages = with pkgs; [
				lua-language-server
				rnix-lsp

				xclip
				wl-clipboard
			];

		plugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-lspconfig;
				config = toLuaFile ./nvim/plugins/lsp.lua;
			}
			neodev-nvim
			lualine-nvim
			{
				plugin = nvim-web-devicons;
				config = toLuaFile ./nvim/plugins/web_devicons.lua;
			}
			{
				plugin = oil-nvim;
				config = toLuaFile ./nvim/plugins/oil.lua;
			}
			tokyonight-nvim
			{
				plugin = telescope-nvim;
				config = toLuaFile ./nvim/plugins/telescope.lua;
			}

			telescope-fzf-native-nvim
			cmp_luasnip
			cmp-nvim-lsp
			cmp-path
			lspkind-nvim
			barbecue-nvim

			luasnip
			friendly-snippets
			{
				plugin = nvim-cmp;
				config = toLuaFile ./nvim/plugins/cmp.lua;
			}
			no-neck-pain-nvim
			colorizer
			nvim-autopairs
			{
				plugin = conform-nvim;
				config = toLuaFile ./nvim/plugins/conform.lua;
			}
			{
				plugin = neorg;
				config = toLuaFile ./nvim/plugins/neorg.lua;
			}
			neorg-telescope
			{
				plugin = image-nvim;
				config = toLuaFile ./nvim/plugins/image.lua;
			}
			vimtex
			
			{
				plugin = (nvim-treesitter.withPlugins (p: [
					p.tree-sitter-nix
					p.tree-sitter-vim
					p.tree-sitter-bash
					p.tree-sitter-lua
					p.tree-sitter-python
					p.tree-sitter-json
					p.tree-sitter-go
					p.tree-sitter-c
					p.tree-sitter-rust
					p.tree-sitter-norg
				]));
				config = toLuaFile ./nvim/plugins/treesitter.lua;
			}

			vim-smoothie

			mini-nvim
			indent-blankline-nvim
			nui-nvim
			nvim-notify
			{
				plugin = noice-nvim;
				config = toLuaFile ./nvim/plugins/noice.lua;
			}
			{
				plugin = fidget-nvim;
				config = toLuaFile ./nvim/plugins/fidget.lua;
			}
		];
  };

  imports = [
    ./configs
  ];

  home.username = "lucky";
  home.homeDirectory = "/home/lucky";
  home.stateVersion = "22.05";
	
  programs.home-manager.enable = true;
	programs.zoxide = {
		enable = true;
		enableFishIntegration = true;
	};
}
