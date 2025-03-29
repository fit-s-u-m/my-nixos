{ pkgs, ... }:

with pkgs; [
    rust-analyzer # rust
    gopls # go
    jdt-language-server # python
    luajitPackages.lua-lsp # lua
    tailwindcss-language-server # tailwind
    emmet-ls # html
  ]
