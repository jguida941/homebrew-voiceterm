class Voiceterm < Formula
  desc "Voice-first terminal overlay for Codex and Claude with local Whisper STT"
  homepage "https://github.com/jguida941/voiceterm"
  url "https://github.com/jguida941/voiceterm/archive/refs/tags/v1.2.5.tar.gz"
  version "1.2.5"
  sha256 "b387c9a1692fe93d9ec523f00717a2b121669a523df5d735feceacc6dfb47a0f"

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
