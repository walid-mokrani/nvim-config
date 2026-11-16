# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim config (Neovim 0.12+), originally based on Kickstart.nvim, using lazy.nvim. Format Lua with `stylua .` (config in `.stylua.toml`: 2 spaces, single quotes, no call parentheses).

## Architecture

- `init.lua` — requires the core modules, then bootstraps lazy.nvim and imports `lua/plugins/`.
- `lua/config/` — core, plugin-independent setup:
  - `options.lua` — options, leader (Space), `vim.g.have_nerd_font` (false)
  - `diagnostics.lua` — `vim.diagnostic.config` and diagnostic keymaps
  - `keymaps.lua` — global keymaps
  - `autocmds.lua` — global autocommands
  - `pick.lua` — helper returning a function that runs a Telescope picker, requiring Telescope only on call (keeps it lazy-loaded)
- `lua/plugins/*.lua` — each returns a lazy.nvim spec; all are auto-imported. Plugin keymaps live in their spec.
- `after/lsp/<name>.lua` — per-server LSP settings, merged over nvim-lspconfig's defaults (`:h lsp-config-merge`).

Augroups are named `user-*`.

## LSP

Native `vim.lsp` with nvim-lspconfig's server configs, set up in `lua/plugins/lsp.lua`: an explicit `vim.lsp.enable { ... }` list and an explicit Mason install list (mason-tool-installer, Mason package names). blink.cmp adds completion capabilities itself. Neovim's default LSP maps (`grn`, `gra`, `gri`, `grt`, `K`) are kept; `gd` and `grr` use Telescope.

To add a server: add it to `vim.lsp.enable`, add its Mason package to `ensure_installed` (unless installed another way), and create `after/lsp/<name>.lua` only if it needs custom settings. Don't define `on_attach` there if nvim-lspconfig already has one for that server (it would be replaced) — use the shared `LspAttach` handler in `lsp.lua` instead.

Servers: rust_analyzer (from rustup, clippy, inlay hints on), dartls (from the Dart SDK), lua_ls, bashls (with shellcheck), marksman.

## Other plugins

- **Formatting:** conform.nvim, format-on-save with LSP fallback; formatters listed in `lua/plugins/formatting.lua`.
- **Completion:** blink.cmp 1.x (lazydev, LSP, path, buffer; dadbod for SQL). `<C-y>` accept, `<C-Space>` open, `<C-l>`/`<C-h>` jump in snippet.
- **Database:** vim-dadbod + dadbod-ui.

## Keymaps

Don't maintain a keymap list here — read the specs, or use `<leader>sk` in Neovim. Leader groups: `c` code, `d` document, `h` git hunk, `l` LSP, `s` search, `t` toggle, `w` workspace.

## Plugin versions

`lazy-lock.json` is committed; commit it after `:Lazy update`.
