class Dottyenv < Formula
  desc "Validate .env files against a declared schema"
  homepage "https://github.com/mfung/dottyenv"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.0/dottyenv-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "89a399c7f988cae01525e2356a4a750016ccca1964eaf39c4d2971089af23a16"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.0/dottyenv-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "33ae68b01ceea9423f67468006b1a56c1d5a8e3e42c5292d3fa79eab6a5968f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.0/dottyenv-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a81250029b35de3320d225112983c3662a278a05fb4f0e268d949a04a00cb0f"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.1.0/dottyenv-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9496f172a8bd36bfc399fd5bf3751ae6bb74664edd42a027fd3d51061a144fa0"
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
    assert_predicate testpath/"dottyenv.toml", :exist?
    system bin/"dottyenv", "check"

    # A missing schema must exit 3, not 1. shell_output raises on a different
    # exit code, so the call is the assertion.
    rm testpath/"dottyenv.toml"
    shell_output("#{bin}/dottyenv check 2>&1", 3)
  end
end
