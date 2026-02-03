# homebrew-voxterm

Homebrew tap for [VoxTerm](https://github.com/jguida941/voxterm) - Voice HUD for AI CLIs with local Whisper STT.

## Install

```bash
brew tap jguida941/homebrew-voxterm
brew install voxterm
```

## Usage

```bash
cd ~/my-project
voxterm
```

First run automatically downloads the Whisper model if missing.

## Options

```bash
voxterm --help                    # Show all options
voxterm --theme dracula           # Use a different theme
voxterm --auto-voice              # Start with auto-voice enabled
voxterm --backend claude          # Use Claude Code instead of Codex
voxterm --mic-meter               # Measure ambient/speech levels
```

### Available Themes
`coral` (default), `catppuccin`, `dracula`, `nord`, `ansi`, `none`

### Available Backends
`codex` (default), `claude`, `gemini`, `aider`, `opencode`, or any custom command

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
| `?` | Show help overlay |
| `Ctrl+Q` | Quit |

## Requirements

- macOS (Apple Silicon or Intel) or Linux with Homebrew
- Builds from source (Rust + CMake installed automatically by Homebrew)

## Troubleshooting

If you encounter issues:
```bash
# Rebuild from source
brew reinstall voxterm

# Check Whisper model
ls ~/.local/share/voxterm/models/
```

## Version

Current: v1.0.37
