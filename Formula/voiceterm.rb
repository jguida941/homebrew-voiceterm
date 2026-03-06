class Voiceterm < Formula
  desc "Voice-first terminal overlay for Codex and Claude with local Whisper STT"
  homepage "https://github.com/jguida941/voiceterm"
  url "https://github.com/jguida941/voiceterm/archive/refs/tags/v1.1.0.tar.gz"
  version "1.1.0"
  sha256 "596b6932749f04b3e74c9b01f539f59b492153021cc33f3cfcf73366ca5dfe99"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "voiceterm", "--manifest-path", "#{libexec}/rust/Cargo.toml"

    (bin/"voiceterm").write <<~EOS
      #!/bin/bash
      export VOICETERM_CWD="$(pwd)"
      export VOICETERM_WRAPPER=1
      exec "#{opt_libexec}/scripts/start.sh" "$@"
    EOS
    chmod 0755, bin/"voiceterm"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base

      Themes: chatgpt, claude, codex, coral, catppuccin, dracula, nord, tokyonight, gruvbox, ansi, none
      Backends: codex (default), claude, gemini (in works), or custom command

      Run `voiceterm --help` for all options.
    EOS
  end
end
