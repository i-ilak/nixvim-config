# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built with [NixVim](https://github.com/nix-community/nixvim) — a declarative Neovim configuration framework using the Nix module system. The output is a standalone Neovim package.

## Commands

```bash
nix build                   # Build the Neovim package
nix flake check             # Run all checks (includes build for all systems)
nix develop                 # Enter dev shell with pre-commit hooks (statix, nixfmt, deadnix)
nix run .                   # Run the built Neovim directly
```

The CI runs `nix flake check --all-systems` and `nix build` on every PR touching `.nix` files.

## Architecture

### Entry Point

`flake.nix` wires together `nixpkgs` (nixos-25.11), `nixvim`, `flake-parts`, `treefmt-nix`, and `pre-commit-hooks`. It exposes a single `packages.default` — the configured Neovim — for four systems (aarch64/x86_64 × linux/darwin).

### Configuration Hub

`config/default.nix` is the central import list. Every plugin and settings file is imported here. When adding a new plugin, create its `.nix` file in the appropriate `config/plugins/<category>/` subdirectory and add the import to `config/default.nix`.

### Plugin Directory Layout

```
config/
├── default.nix       # Imports everything
├── settings.nix      # Core vim options (indent, folds, clipboard, spell, etc.)
├── keymaps.nix       # All keybindings
├── auto_cmds.nix     # Autocommands
├── file_types.nix    # Custom filetype detection
├── extra.nix         # Extra plugins/raw Lua not covered by nixvim modules
└── plugins/
    ├── lz_n.nix      # Lazy-loading (lz.n)
    ├── cmp/          # Completion: nvim-cmp, lspkind, autopairs, schemastore
    ├── editor/       # Neo-tree, treesitter, fold (ufo), leap, surround, etc.
    ├── git/          # Gitsigns, Neogit, Lazygit, gitblame
    ├── lsp/          # LSP servers, conform (formatting), fidget, DAP
    ├── snippets/     # LuaSnip
    ├── themes/       # Catppuccin
    ├── ui/           # Lualine, bufferline, startup screen, web-devicons
    └── utils/        # Telescope, which-key, mini.nvim, toggleterm, obsidian
```

### Key Patterns

- **Module pattern**: Each file is `{ pkgs, ... }: { ... }` or `{ ... }: { ... }`.
- **Raw Lua**: Complex plugin setup that nixvim doesn't expose as options uses `__raw = ''lua code''`.
- **Cross-platform**: Darwin-specific config (clipboard, etc.) uses `pkgs.stdenv.isDarwin` conditionals.
- **Lazy loading**: Plugins are registered with `lz.n` for deferred loading.
- **Formatting**: `format.nix` uses `treefmt-nix` — run `nix fmt` to auto-format all Nix/YAML files.

### LSP Configuration

`config/plugins/lsp/lsp.nix` configures: clangd (C++), rust_analyzer, pyright, lua_ls, nil_ls, marksman, yamlls, and others. Formatting is handled separately by `conform.nix` (not the LSP formatter). DAP debugging is in `dap.nix`.
