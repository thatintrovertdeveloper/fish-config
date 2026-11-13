# PROJECT KNOWLEDGE BASE

**Generated:** 2026-11-11

## OVERVIEW
Project: **fish-config** — personal fish shell configuration, tracked as a dotfiles repo cloned directly into `~/.config/fish`.
Stack: fish shell 4.x, Fisher (plugin manager), Starship prompt, zoxide, nvm.fish, Linux Homebrew.

## STRUCTURE
*   `config.fish`: main entry point, sourced on every shell start. Interactive-only init (starship, zoxide) is guarded by `status is-interactive`.
*   `conf.d/`: snippet files auto-sourced by fish before `config.fish` (currently empty).
*   `functions/`: one function per file, auto-loaded by fish on first call. Git workflow (`gwip`, `gbda`, ...), git helpers (`__git.*.fish`), nvm.fish plugin, system toggles (`toggle_*.fish`).
*   `completions/`: tab completions (`fisher`, `nvm`, `bun`).
*   `fish_plugins`: Fisher plugin list (`jorgebucaran/fisher`, `dracula/fish`).
*   `secrets.fish` (gitignored): API keys sourced by `config.fish`; template in `.secrets.fish.example`.
*   `fish_variables` (gitignored): system-specific universal variable state.
*   `themes/`, `completions/`, `functions/` contain `*.backup` leftovers and a broken `conf.d.backup` symlink (Mac Dropbox path) — ignored by git, safe to delete.

## COMMANDS
| Action | Command |
|--------|---------|
| Syntax check config | `fish -n ~/.config/fish/config.fish` |
| Reload config in current shell | `source ~/.config/fish/config.fish` |
| Install plugins from `fish_plugins` | `fisher update` |
| Install one plugin | `fisher install <owner>/<repo>` |
| Load config in fresh shell test | `fish -c 'echo $EDITOR'` |
| Set default branch for `gwip` etc. | handled by `functions/__git.default_branch.fish` |

No build/test system — this is a config repo. "Testing" = `fish -n` syntax check plus launching `fish` and exercising the changed function.

## CODING STANDARDS
*   **Language**: fish 4.x scripting only. Never paste bash/zsh snippets (`export X=...`, `[[ ]]`, `autoload`, `compdef`, zsh completion functions) into `config.fish` — this has happened before and broke startup (`fish -n` exit 127). Convert: `export` → `set -gx`, PATH appends → `fish_add_path`, sourced sh init scripts usually cannot work in fish (note them in comments instead).
*   **Style**: one function per file in `functions/`, filename = function name, description via `-d "..."`. Completions via `complete --command ...` in `completions/`.
*   **Config hygiene**: interactive-only work inside `if status is-interactive` block; PATH additions via `fish_add_path` (dedupes, silently skips nonexistent dirs); env vars via `set -gx`; tool init via `tool init fish | source`.
*   **Plugins**: add via `fisher install` (writes to `fish_plugins`), not by hand-editing files.

## WHERE TO LOOK
*   **Main config**: `config.fish`
*   **Functions**: `functions/` (nvm.fish is vendored plugin code — treat as third-party, don't restyle)
*   **Secrets template**: `.secrets.fish.example`
*   **Human docs**: `README.md` (installation, full function list)

## NOTES
*   Repo path IS the live config: edits to `config.fish` or `functions/*.fish` affect the user's real shell immediately (new shells) — no deploy step, but also no safety net.
*   `config.fish` was polluted before by installer output from pyenv/sdkman/opencode/strix/antigravity; when a CLI prints "add this to your shell config", it is bash/zsh by default and must be translated to fish.
*   Multi-machine repo (originally macOS, now Linux): never hardcode `/Users/...` or machine-specific absolute paths; use `$HOME`. `fish_add_path` guards missing dirs.
*   `gpsup` alias pushes to `origin main` unconditionally — known limitation, intentional for the user's flow.
*   Prompt/theme is Starship (config lives in `~/.config/starship.toml`, not in this repo). Dracula fish theme via Fisher.
