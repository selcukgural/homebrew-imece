# Written by scripts/formula.sh from the SHA256SUMS of imece v0.1.202611100124.
# Do not edit by hand: update.yml writes it again for every release.
class Imece < Formula
  desc "One terminal for a team of Claude Code agents"
  homepage "https://selcukgural.github.io/imece/"
  version "0.1.202611100124"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611100124/imece-aarch64-apple-darwin.tar.gz"
      sha256 "77d4c830b7b819477b3471ab255031adb689d60e6d0cf51bb87ef56bf63b4507"
    end
    on_intel do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611100124/imece-x86_64-apple-darwin.tar.gz"
      sha256 "d3c1c89008e6a3133cfe56e5e9b861f33c7feb5e6484fd8a25406de9f4e3f351"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611100124/imece-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1123de30440d6288594b4396f1f281a8be357956cb4b250d9d80def4789bec4c"
    end
    on_intel do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611100124/imece-x86_64-unknown-linux-musl.tar.gz"
      sha256 "00f2f26633893ac20d586350c94f774bbdcfc6d92e275ec00206cec35b05c1a2"
    end
  end

  def install
    bin.install "imece"
  end

  def caveats
    <<~TEXT
      imece drives Claude Code: claude must be on PATH and signed in
      (https://claude.com/claude-code). Run imece doctor to see what else a
      start needs.
    TEXT
  end

  test do
    assert_equal "imece #{version}", shell_output("#{bin}/imece --version").strip
  end
end
