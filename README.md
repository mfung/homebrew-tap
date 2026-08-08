# homebrew-tap

Homebrew formulae for [dottyenv](https://github.com/mfung/dottyenv).

```bash
brew tap mfung/tap
brew install dottyenv
```

Works on macOS (Apple Silicon and Intel) and Linux (x86_64 and arm64). The formula
installs a prebuilt binary from the project's GitHub Releases, so there is no Rust
toolchain required and no compile step.

## Updating the formula for a new release

The `url` and `sha256` values come straight from the release's `SHA256SUMS`:

```bash
curl -sL https://github.com/mfung/dottyenv/releases/download/vX.Y.Z/SHA256SUMS
```

Bump `version`, then replace all four url/sha256 pairs. Generating them from that
file rather than copying by hand avoids transcription errors.
