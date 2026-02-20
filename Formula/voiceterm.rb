class Voiceterm < Formula
  desc "Voice-first HUD overlay for AI CLIs with local Whisper STT"
  homepage "https://github.com/jguida941/voiceterm"
  url "https://github.com/jguida941/voiceterm/archive/refs/tags/v1.0.84.tar.gz"
  version "1.0.84"
  sha256 "2b3a5eba716336f8bf03076253928225b91c81c243c3b5b14975d6bedf54d6f2"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "voiceterm", "--manifest-path", "#{libexec}/src/Cargo.toml"

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
