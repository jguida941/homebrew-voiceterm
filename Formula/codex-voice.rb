class CodexVoice < Formula
  desc "Voice-enabled overlay for Codex CLI"
  homepage "https://github.com/jguida941/codex-voice"
  url "https://github.com/jguida941/codex-voice/archive/refs/tags/v1.0.27.tar.gz"
  version "1.0.27"
  sha256 "8f2d49929d91d02f758ed278fda27ed2d0b1c00be0f8b740715911f4b316b45a"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "codex-voice", "--manifest-path", "#{libexec}/rust_tui/Cargo.toml"
    (bin/"codex-voice").write <<~EOS
      #!/bin/bash
      export CODEX_VOICE_CWD="$(pwd)"
      export CODEX_VOICE_WRAPPER=1
      exec "#{libexec}/start.sh" "$@"
    EOS
    chmod 0755, bin/"codex-voice"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base
    EOS
  end
end
