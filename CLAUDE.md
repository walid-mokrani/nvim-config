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
- **Plugin manager:** lazy.nvim (auto-installed if missing)
- **LSP:** nvim-lspconfig with Mason for automatic installation
- **Formatting:** conform.nvim with format-on-save (disabled for C/C++)
- **Completion:** nvim-cmp with LSP source
- **Flutter:** flutter-tools.nvim with FVM support

## LSP Servers Configured

rust_analyzer (with clippy), bashls, cssls, html, jsonls, yamlls, ts_ls, lua_ls

## Key Bindings Reference

**Search (Telescope):** `<leader>s` prefix - `sf` files, `sg` grep, `sh` help, `sk` keymaps
**LSP:** `gd` definition, `gr` references, `K` hover, `<leader>ca` code action, `<leader>rn` rename
**Document/Debug:** `<leader>d` prefix - `ds` document symbols, `db` breakpoint, `dc` continue
**Workspace:** `<leader>w` prefix - `ws` workspace symbols
**Toggle:** `<leader>t` prefix - `tb` git blame, `tD` git deleted, `th` inlay hints
**Git:** `<leader>h` prefix for hunk operations, `]c`/`[c` navigate changes
**Flutter:** `<leader>F` prefix - `Fc` commands, `Ff` fvm
**Claude Code:** `<leader>A` prefix - `Ac` new session, `Ar` resume, `At` toggle, `Ao` continue, `Av` verbose, `<C-\>` toggle window
**Format:** `<leader>f` format buffer

## Adding New Plugins

Create a new file in `lua/plugins/` returning a lazy.nvim plugin spec table. The file will be automatically loaded.
