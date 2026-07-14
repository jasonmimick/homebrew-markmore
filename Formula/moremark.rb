class Moremark < Formula
  desc "More for markdown - native macOS previewer for the CLI"
  homepage "https://github.com/jasonmimick/moremark"
  url "https://github.com/jasonmimick/moremark/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d4bbc423dc3c39c3facde40c862caa010fb6e54598734de5dadd716f2c6b291e"
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
