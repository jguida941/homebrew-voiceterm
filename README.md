# homebrew-codex-voice

Homebrew tap for [codex-voice](https://github.com/jguida941/codex-voice) - Rust voice overlay for Codex CLI with local Whisper STT.

## Install

```bash
brew tap jguida941/codex-voice
brew install codex-voice
```

## Usage

```bash
cd ~/my-project
codex-voice
```

First run downloads the Whisper model if missing.

## Pre-download model (optional)

```bash
$(brew --prefix)/opt/codex-voice/libexec/scripts/setup.sh models --base
```

## Notes

- Builds from source (requires Rust + CMake)
- Current version: v1.0.28
