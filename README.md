# Homebrew tap for imece

```sh
brew install selcukgural/imece/imece
```

Installs `imece` from the [imece releases](https://github.com/selcukgural/imece/releases):
macOS arm64 and x86_64, Linux x86_64 and arm64.

`Formula/imece.rb` is written by `.github/workflows/update.yml` for the latest
published release, every day and on demand. It checks every archive against the
release's `SHA256SUMS` and its build provenance attestation (signed by imece's
`release.yml` on the release tag), and installs and tests the formula on macOS
and Linux before committing it. Do not edit the formula by hand.

imece drives [Claude Code](https://claude.com/claude-code), which must be on
PATH and signed in; `imece doctor` says what else a start needs.

The scripts and the workflow are copied from
[homebrew-lonca](https://github.com/selcukgural/homebrew-lonca).

imece: https://selcukgural.github.io/imece/
