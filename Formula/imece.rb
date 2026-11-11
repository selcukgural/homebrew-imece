# Written by scripts/formula.sh from the SHA256SUMS of imece v0.1.202611111627.
# Do not edit by hand: update.yml writes it again for every release.
class Imece < Formula
  desc "One terminal for a team of Claude Code agents"
  homepage "https://selcukgural.github.io/imece/"
  version "0.1.202611111627"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611111627/imece-aarch64-apple-darwin.tar.gz"
      sha256 "6c9ac31b7549f4b823faa01fce69c08f2a954548743dbbd8608b01d6d6660af7"
    end
    on_intel do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611111627/imece-x86_64-apple-darwin.tar.gz"
      sha256 "bdb714e6c00a6692eabe9b866391fec9a2087fc2a975cad790f0de91069d05f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611111627/imece-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e4cf2de32f97cd4963a5e6891d96f1f6c547996f6605c120d238cfdf4ce740de"
    end
    on_intel do
      url "https://github.com/selcukgural/imece/releases/download/v0.1.202611111627/imece-x86_64-unknown-linux-musl.tar.gz"
      sha256 "825342dfa54b6bf772f7c07226d26cec5a8f88d76b4709a42bc16121ca43f9cb"
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
