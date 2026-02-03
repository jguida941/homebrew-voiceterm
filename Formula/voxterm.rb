class Voxterm < Formula
  desc "Voice HUD for AI CLIs with local Whisper STT"
  homepage "https://github.com/jguida941/voxterm"
  url "https://github.com/jguida941/voxterm/archive/refs/tags/v1.0.37.tar.gz"
  version "1.0.37"
  sha256 "e379ca4dcacac36f02b4bafc53c54d7c9c403f2f7e3c0d6f960943116a07b120"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "voxterm", "--manifest-path", "#{libexec}/src/Cargo.toml"
    (bin/"voxterm").write <<~EOS
      #!/bin/bash
      export VOXTERM_CWD="$(pwd)"
      export VOXTERM_WRAPPER=1
      exec "#{libexec}/scripts/start.sh" "$@"
    EOS
    chmod 0755, bin/"voxterm"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base

      Themes: coral, catppuccin, dracula, nord, ansi, none
      Backends: codex (default), claude, gemini, aider, opencode, or custom command

      Run `voxterm --help` for all options.
    EOS
  end
end
