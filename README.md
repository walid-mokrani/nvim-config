# nvim-config

Personal Neovim configuration, originally based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and split into modules.

Requires the latest stable Neovim (0.12+), `git`, `make`, a C compiler and `ripgrep`.

## Install

```sh
git clone git@github.com:walid-mokrani/nvim-config.git ~/.config/nvim
nvim  # lazy.nvim bootstraps itself and installs plugins from lazy-lock.json
```

## Layout

| Path | Purpose |
|---|---|
| `init.lua` | Loads core modules, bootstraps lazy.nvim |
| `lua/config/options.lua` | Editor options |
| `lua/config/diagnostics.lua` | Diagnostic display and keymaps |
| `lua/config/keymaps.lua` | Global keymaps |
| `lua/config/autocmds.lua` | Autocommands |
| `lua/config/pick.lua` | Lazy Telescope picker helper |
| `lua/plugins/*.lua` | One lazy.nvim spec per plugin group, auto-imported |
| `after/lsp/<name>.lua` | Per-server LSP settings, merged over nvim-lspconfig defaults |

Plugin versions are pinned in `lazy-lock.json`; run `:Lazy update` to bump them, then commit the lockfile.
