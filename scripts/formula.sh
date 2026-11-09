#!/bin/sh
# Copied from homebrew-lonca@4e00158f06d175bed0449d4339c1de52c97ba7e4 scripts/formula.sh and reworked for imece.
#
# Writes Formula/imece.rb for an imece release to stdout.
#
#   scripts/formula.sh VERSION SHA256SUMS
#
# VERSION is the release's version without the `v` (0.1.202611100124); SHA256SUMS is
# that release's file, already checked against the archives and their
# attestations (update.yml does both). Fails when an archive is missing
# from it or a checksum is not 64 hex digits.
set -eu

[ "$#" -eq 2 ] || { echo "usage: $0 VERSION SHA256SUMS" >&2; exit 2; }
version=$1
sums=$2

case "$version" in
    *[!0-9A-Za-z.-]* | "") echo "not a version: $version" >&2; exit 1 ;;
esac

sum() {
    s=$(grep "  imece-$1.tar.gz\$" "$sums" | cut -d ' ' -f 1)
    case "$s" in
        *[!0-9a-f]* | "") echo "SHA256SUMS has no checksum for imece-$1.tar.gz" >&2; exit 1 ;;
    esac
    [ "${#s}" -eq 64 ] || { echo "not a SHA-256: $s" >&2; exit 1; }
    printf '%s' "$s"
}

mac_arm=$(sum aarch64-apple-darwin)
mac_intel=$(sum x86_64-apple-darwin)
linux_arm=$(sum aarch64-unknown-linux-musl)
linux_intel=$(sum x86_64-unknown-linux-musl)
url="https://github.com/selcukgural/imece/releases/download/v$version"

cat <<EOF
# Written by scripts/formula.sh from the SHA256SUMS of imece v$version.
# Do not edit by hand: update.yml writes it again for every release.
class Imece < Formula
  desc "One terminal for a team of Claude Code agents"
  homepage "https://selcukgural.github.io/imece/"
  version "$version"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "$url/imece-aarch64-apple-darwin.tar.gz"
      sha256 "$mac_arm"
    end
    on_intel do
      url "$url/imece-x86_64-apple-darwin.tar.gz"
      sha256 "$mac_intel"
    end
  end

  on_linux do
    on_arm do
      url "$url/imece-aarch64-unknown-linux-musl.tar.gz"
      sha256 "$linux_arm"
    end
    on_intel do
      url "$url/imece-x86_64-unknown-linux-musl.tar.gz"
      sha256 "$linux_intel"
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
EOF
