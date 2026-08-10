class Dottyenv < Formula
  desc "Validate .env files against a declared schema"
  homepage "https://github.com/mfung/dottyenv"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.0/dottyenv-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "cacfb2b2c2a828aa919f7dfe1fc140ad0114a956d539255b05a5e43bdbbd57da"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.0/dottyenv-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "3cc81b810ce7a60b99e970f454cf42e40e91d77ce18babf168484b1e3a621336"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.0/dottyenv-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8c83407a97d4ea52629e3c198fe741e4c34cf2b8affb33beb06ab212fb81a30"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.0/dottyenv-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3d549b7263fc41c843d7cf2dd7a9f13163b5a537523ce94102a4acade2bd5e46"
    end
  end

  def install
    bin.install "dottyenv"
    generate_completions_from_executable(bin/"dottyenv", "completions")
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
