{ inputs, pkgs, ... }:
let

  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
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
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]));
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    rust-analyzer-unwrapped
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    extraLuaPackages = ps: [ ps.magick ];

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}
/*{
  programs.neovim =
  let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
  p.bash
  p.comment
  p.css
  p.dockerfile
  p.fish
  p.gitattributes
  p.gitignore
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
  p.rust
  p.toml
  p.typescript
  p.vue
  p.yaml
  ]));
  in
  {
  enable = true;

  extraLuaConfig = ''
  	${builtins.readFile ./nvim/init.lua}
  '';
  ${builtins.readFile ./nvim/plugins/other.lua}
  extraPackages = with pkgs; [
  lua-language-server
  rnix-lsp

  xclip
  wl-clipboard
  ];

  plugins = with pkgs.vimPlugins; [
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
  }
  ];
  home.file."./.config/nvim/" = {
  source = ./nvim;
  recursive = true;
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
  recursive = true;
  source = treesitterWithGrammars;

  };     
  };
  }
*/
