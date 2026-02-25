class Voiceterm < Formula
  desc "Voice-first terminal overlay for Codex and Claude with local Whisper STT"
  homepage "https://github.com/jguida941/voiceterm"
  url "https://github.com/jguida941/voiceterm/archive/refs/tags/v1.0.94.tar.gz"
  version "1.0.94"
  sha256 "149e48439aba85b47e637cfc28d8af84ec2584d447d64535bb27cad99e49d44d"

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
