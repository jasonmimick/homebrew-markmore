class Moremark < Formula
  desc "More for markdown - native macOS previewer for the CLI"
  homepage "https://github.com/jasonmimick/moremark"
  url "https://github.com/jasonmimick/moremark/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "b31d3d27923bd57f80219e62657865fa8714d629e55244a4344cff6b0c05ee25"
  license "MIT"

  depends_on :macos

  def install
    # Builds from source with swiftc (Xcode CLT) — locally-built binaries
    # carry no quarantine flag, so no Gatekeeper friction.
    system "bash", "build.sh", "--build-only"
    prefix.install "moremark.app"
    bin.write_exec_script prefix/"moremark.app/Contents/MacOS/moremark"
  end

  def caveats
    <<~EOS
      moremark opens a native window: moremark README.md
      Pipe with: git log | moremark -
    EOS
  end

  test do
    output = shell_output("#{bin}/moremark --help 2>&1", 64)
    assert_match "usage: moremark", output
  end
end
