# Neovim configuration using [`nixvim`](https://github.com/nix-community/nixvim)

Personal neovim setup

- LSP support for C++, Rust, Python, and many more
- Telescope for easy browsing of text, files, and symbols
- DAP support, including DAP UI
- Neogit for version control
- fidget for notifcations
- lualine as statusline
- bufferline for buffer overview
- overseer to build, run, debug projects
- and many more things.

To give it a test run, you can simply run

```bash
nix run 'git+https://tangled.org/ilak.ch/nixvim-config' -- test_file.py
```

This configuration has taken inspiration from the following contributors.

- [khanelivim](https://github.com/khaneliman/khanelivim)
- [dc-tec](https://github.com/dc-tec/nixvim)
