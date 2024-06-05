{ inputs
, pkgs
, ...
}:
let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.elixir
    p.erlang
    p.fish
    p.gitattributes
    p.gitignore
    p.gleam
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.ruby
    p.rust
    p.slint
    p.templ
    p.toml
    p.typescript
    p.vue
    p.yaml
    p.typst
  ]);
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    #rust-analyzer-unwrapped
    #rnix-lsp
    fzf
  ];

  programs.neovim = {
    enable = true;
    #package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    extraLuaPackages = ps: [ ps.magick ];

    /*
      plugins = [
      treesitterWithGrammars
      ];
    */

    extraPackages = with pkgs; [
      fzf
      lua-language-server
      #rnix-lsp

      xclip
      wl-clipboard
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  /*
    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
    };
  */
}
