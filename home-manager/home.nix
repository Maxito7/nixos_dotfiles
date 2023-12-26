{ pkgs, inputs, ... }:
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

        {
          plugin = lualine-nvim;
          config = toLuaFile ./nvim/plugins/lualine.lua;
        }

        {
          plugin = oil-nvim;
          config = toLuaFile ./nvim/plugins/oil.lua;
        }

        {
          plugin = tokyonight-nvim;
          config = toLuaFile ./nvim/plugins/tokyonight.lua;
        }

        telescope-fzf-native-nvim
        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugins/telescope.lua;
        }

        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        lspkind-nvim
        luasnip
        friendly-snippets
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugins/cmp.lua;
        }

        nvim-navic
        {
          plugin = barbecue-nvim;
          config = toLuaFile ./nvim/plugins/barbecue.lua;
        }

        {
          plugin = no-neck-pain-nvim;
          config = toLuaFile ./nvim/plugins/neck_pain.lua;
        }

        {
          plugin = nvim-colorizer-lua;
          config = toLuaFile ./nvim/plugins/colorizer.lua;
        }

        {
          plugin = nvim-autopairs;
          config = toLuaFile ./nvim/plugins/autopairs.lua;
        }

        {
          plugin = conform-nvim;
          config = toLuaFile ./nvim/plugins/conform.lua;
        }

        neorg-telescope
        {
          plugin = neorg;
          config = toLuaFile ./nvim/plugins/neorg.lua;
        }

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
            p.tree-sitter-markdown
          ]));
          config = toLuaFile ./nvim/plugins/treesitter.lua;
        }

        {
          plugin = indent-blankline-nvim;
          config = toLuaFile ./nvim/plugins/indent_blankline.lua;
        }

        {
          plugin = mini-nvim;
          config = toLuaFile ./nvim/plugins/mini.lua;
        }

        {
          plugin = nvim-web-devicons;
          config = toLuaFile ./nvim/plugins/web_devicons.lua;
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
