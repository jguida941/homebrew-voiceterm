# homebrew-voxterm

Homebrew tap for [VoxTerm](https://github.com/jguida941/voxterm) - Voice HUD for AI CLIs with local Whisper STT.

## Install

```bash
brew tap jguida941/voxterm
brew install voxterm
```

Upgrade:

```bash
brew update
brew upgrade voxterm
```

## Usage

```bash
cd ~/my-project
voxterm
```

First run downloads a Whisper model if missing. Homebrew installs store models at:
`~/.local/share/voxterm/models` (override with `VOXTERM_MODEL_DIR`).

## Options

```bash
voxterm --help                    # Show all options
voxterm --theme dracula           # Use a different theme
voxterm --auto-voice              # Start with auto-voice enabled
voxterm --claude                  # Use Claude Code instead of Codex
voxterm --mic-meter               # Measure ambient/speech levels
voxterm --hud-style hidden        # Minimal UI (blank when idle)
```

### Available Themes
`chatgpt`, `claude`, `codex`, `coral` (default), `catppuccin`, `dracula`, `nord`, `tokyonight`, `gruvbox`, `ansi`, `none`

### Available Backends
`codex` (default), `claude`

## Pre-download Whisper Model (optional)

```bash
$(brew --prefix)/opt/voxterm/libexec/scripts/setup.sh models --base
```

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+R` | Record (push-to-talk) |
| `Ctrl+V` | Toggle auto-voice |
| `Ctrl+T` | Toggle send mode |
| `Ctrl+Y` | Theme picker |
| `Ctrl+O` | Settings menu |
| `Ctrl+]` | Mic sensitivity up |
| `Ctrl+\` | Mic sensitivity down |
| `?` | Show help overlay |
| `Ctrl+Q` | Quit |

## Requirements

- macOS (Apple Silicon or Intel) or Linux with Homebrew
- Builds from source (Rust + CMake installed automatically by Homebrew)

## Troubleshooting

```bash
# Rebuild from source
brew reinstall voxterm

# Check Whisper model
ls ~/.local/share/voxterm/models/
```

More help: https://github.com/jguida941/voxterm/blob/master/guides/TROUBLESHOOTING.md

## Version

Current: v1.0.63
