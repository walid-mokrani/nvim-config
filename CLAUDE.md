# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on Kickstart.nvim, modularized for maintainability. It uses lazy.nvim as the plugin manager.

## Architecture

**Entry point:** `init.lua` loads core modules and bootstraps lazy.nvim

**Core modules in `lua/`:**
- `options.lua` - Vim options (leader key is Space, relative line numbers enabled)
- `keymaps.lua` - Key mappings (window navigation, buffer management)
- `autocmds.lua` - Autocommands (yank highlighting)

**Plugin configs in `lua/plugins/`:** Each file returns a lazy.nvim plugin spec. All files in this directory are auto-loaded via `{ import = 'plugins' }`.

## Key Configuration Details

- **Leader key:** Space
- **Nerd Font:** Disabled by default (`vim.g.have_nerd_font = false` in options.lua)
- **Plugin manager:** lazy.nvim (auto-installed if missing); `lazy-lock.json` is committed, so commit it after `:Lazy update`
- **LSP:** native `vim.lsp` (Neovim 0.11+) with nvim-lspconfig's defaults. In `lua/plugins/lsp.lua`: shared capabilities via `vim.lsp.config('*')`, servers turned on by an explicit `vim.lsp.enable { ... }` list, and an explicit Mason install list (mason-tool-installer, Mason package names). Per-server settings go in `after/lsp/<name>.lua`, which overrides nvim-lspconfig (see `:h lsp-config-merge`). To add a server: add it to `vim.lsp.enable`, add its Mason package to `ensure_installed` (unless installed another way), and create `after/lsp/<name>.lua` only if it needs custom settings.
- **Formatting:** conform.nvim with format-on-save (LSP formatting as fallback). Formatters: stylua (Lua), rustfmt (Rust), dart_format (Dart), sql-formatter (SQL).
- **Completion:** nvim-cmp with LSP source
- **Database:** vim-dadbod + dadbod-ui with dadbod completion for SQL

## LSP Servers Configured

rust_analyzer (with clippy, inlay hints on by default; installed via `rustup component add rust-analyzer`, not Mason), bashls, lua_ls

## Key Bindings Reference

**Search (Telescope):** `<leader>s` prefix - `sf` files, `sg` grep, `sh` help, `sk` keymaps
**LSP:** `gd` definition, `grr` references (Telescope), `gI` implementation, `K` hover, `<leader>ca`/`gra` code action, `<leader>rn`/`grn` rename, `]e`/`[e` next/prev error
**Document:** `<leader>d` prefix - `ds` document symbols
**Workspace:** `<leader>w` prefix - `ws` workspace symbols
**Toggle:** `<leader>t` prefix - `tb` git blame, `tD` inline hunk preview, `tg` git line highlights, `tw` word diff, `th` inlay hints
**Git:** `<leader>h` prefix for hunk operations, `]c`/`[c` navigate changes
**Format:** `<leader>f` format buffer

## Adding New Plugins

Create a new file in `lua/plugins/` returning a lazy.nvim plugin spec table. The file will be automatically loaded.
