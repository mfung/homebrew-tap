class Dottyenv < Formula
  desc "Validate .env files against a declared schema"
  homepage "https://github.com/mfung/dottyenv"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.1/dottyenv-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "90dd7a7f70811e201b8049b8ca42eb894c37cdc1abfa04eaefa4929402286955"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.1/dottyenv-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "c4e3267537d99fd3bad91893f44c967ca13b370c170529acee4b4ba2e43e0a30"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.1/dottyenv-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb9a20fb68a4f05f19e768357842f8dcf70cf54af1c6ce32f2faa26a9e4f5f03"
    end
    on_intel do
      url "https://github.com/mfung/dottyenv/releases/download/v0.2.1/dottyenv-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31beb1054f6013206498f3a471ade9637f10093eb6fd1d2b6d73f37938267e9c"
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
