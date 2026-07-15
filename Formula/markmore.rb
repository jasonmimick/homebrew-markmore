class Markmore < Formula
  desc "More for markdown - native macOS previewer for the CLI"
  homepage "https://github.com/jasonmimick/markmore"
  url "https://github.com/jasonmimick/markmore/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "afdf878d4015e2db5a11869941b91f0d8034f883e0ea9b5e59fd55c76d108baf"
  license "MIT"

  depends_on :macos

  def install
    # Builds from source with swiftc (Xcode CLT) — locally-built binaries
    # carry no quarantine flag, so no Gatekeeper friction.
    system "bash", "build.sh", "--build-only"
    prefix.install "markmore.app"
    bin.write_exec_script prefix/"markmore.app/Contents/MacOS/markmore"
  end

  def caveats
    <<~EOS
      markmore opens a native window: markmore README.md
      Pipe with: git log | markmore -
    EOS
  end

  test do
    output = shell_output("#{bin}/markmore --help 2>&1", 64)
    assert_match "usage: markmore", output
  end
end
