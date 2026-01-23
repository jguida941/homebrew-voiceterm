class CodexVoice < Formula
  desc "Voice-enabled overlay for Codex CLI"
  homepage "https://github.com/jguida941/codex-voice"
  url "https://github.com/jguida941/codex-voice/archive/refs/tags/v0.2.2.tar.gz"
  version "0.2.2"
  sha256 "0ff14e08439527e836b7af412ac249e93a94ae7c608d0017f09c648d2d20b2de"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "codex_overlay", "--manifest-path", "#{libexec}/rust_tui/Cargo.toml"

    bin.install "#{libexec}/rust_tui/target/release/codex_overlay" => "codex-overlay"
    (bin/"codex-voice").write <<~EOS
      #!/bin/bash
      export CODEX_VOICE_CWD="$(pwd)"
      export CODEX_VOICE_MODE=overlay
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
