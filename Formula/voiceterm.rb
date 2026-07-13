class Voiceterm < Formula
  desc "Voice-first terminal overlay for Codex and Claude with local Whisper STT"
  homepage "https://github.com/jguida941/voiceterm"
  url "https://github.com/jguida941/voiceterm/archive/refs/tags/v1.2.4.tar.gz"
  version "1.2.4"
  sha256 "e1f3805c5f04a5dad90305173011e79ac3a6a5401ee191f2a5e7a8c5bf36cf04"

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
