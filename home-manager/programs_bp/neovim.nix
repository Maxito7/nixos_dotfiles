
{ config, pkgs, nixvim, ...}: {
  
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      rust-analyzer
    ];
  };

  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    extraConfigLua = ''
      print("Hi!")
    '';

    extraPlugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      luasnip
      no-neck-pain-nvim
    ];

    plugins = {
      # Dashboard
      alpha = {
        enable = true;
      
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
                "███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗"
                "████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝"
                "██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗"
                "██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║"
                "██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║"
                "╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
            ];
          }
          { 
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
          {
            command = "<CMD>ene <CR>";
            desc = "  New file";
            shortcut = "e";
          }
          {
            command = ":qa<CR>";
            desc = "󰩈  Quit Neovim";
            shortcut = "SPC q";
          }
          {
            command = ":ToggleTerm<CR>";
            desc = "  Toggle Term";
            shortcut = "SPC t";
          }
          ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "United we stand, divided we fall.";
          }
        ];
      };
      treesitter.enable = true;
      presence-nvim.enable = true;
      nvim-autopairs.enable = true;
      nix.enable = true;
      nvim-colorizer.enable = true;
      markdown-preview.enable = true;
      lsp-format.enable = true;
      lsp = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
          pylsp.enable = true;
          nixd.enable = true;
          clangd.enable = true;
        };
      };
      
      nvim-cmp.enable = true;
      lualine = {
        enable = true;
        iconsEnabled = true;
      };
      # Cmp
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lua.enable = true;
      #cmp-nvim-ultisnips.enable = true;

      cmp-omni.enable = true;
      cmp-pandoc-nvim.enable = true;
      cmp-pandoc-references.enable = true;
      cmp-path.enable = true;
      cmp-rg.enable = true;
      cmp-snippy.enable = true;
      cmp-spell.enable = true;
      cmp-tabnine.enable = true;
      cmp-tmux.enable = true;
      cmp-treesitter.enable = true;
      cmp-vim-lsp.enable = true;
      cmp-vimwiki-tags.enable = true;
      cmp-vsnip.enable = true;
      cmp-zsh.enable = true;
    
      nvim-cmp.snippet.expand = "luasnip";
      nvim-cmp.mappingPresets = ["insert"];
      nvim-cmp.sources = [
	      {name = "nvim_lsp";}
	      {name = "luasnip"; }
        {name = "buffer"; }
        {name = "path"; }
      ];
      nvim-cmp.mapping = {
        "<Tab>" = "cmp.mapping.confirm({ select = true })";
      };

      oil = {
        enable = true;
        defaultFileExplorer = true;
        useDefaultKeymaps = true;
      };
      neorg.enable = true;
      barbecue.enable = true;
    };

    colorscheme = "tokyonight-night";

  };
}

