class Moremark < Formula
  desc "More for markdown - native macOS previewer for the CLI"
  homepage "https://github.com/jasonmimick/moremark"
  url "https://github.com/jasonmimick/moremark/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a0c6fe03b9de932204e4a4f5f13c6b6f2bb564dec9357b902a61a1b53c563dbc"
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
