class Dottyenv < Formula
  desc "Validate .env files against a declared schema"
  homepage "https://github.com/mfung/dottyenv"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.1/dottyenv-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "4a628a1f3f710b36da8123f1867c59ab1b19971dbf254ca232d299f974b4da3c"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.1/dottyenv-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "ee3f42d1c0fd3100a9d4ba43a1a50bb9f4efe605732be788e9b1a717d6aee019"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.1/dottyenv-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1eb17db192ec7f471cec6c430084fda079fc04f0d76431c044c2df0aa2bd0b00"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.1/dottyenv-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "262ffae7e1d70ad99a7c2a130ad48e734502354a5f3a51daabdba5486307239e"
    end
  end

  def install
    bin.install "dottyenv"
  end

  test do
    assert_match "dottyenv #{version}", shell_output("#{bin}/dottyenv --version")

    # Exercise the real workflow rather than just the version string.
    (testpath/".env").write("DATABASE_URL=postgres://localhost/app\n")
    system bin/"dottyenv", "init", "--quiet"
    assert_path_exists testpath/"dottyenv.toml"
    system bin/"dottyenv", "check"

    # A missing schema must exit 3, not 1. shell_output raises on a different
    # exit code, so the call is the assertion.
    rm testpath/"dottyenv.toml"
    shell_output("#{bin}/dottyenv check 2>&1", 3)
  end
end
