class ImessageAnalysis < Formula
  desc "Extract, query, and analyse your Mac iMessage history"
  homepage "https://github.com/DecisionNerd/imessage-analysis"
  url "https://github.com/DecisionNerd/imessage-analysis/releases/download/v0.1.0/imessage-analysis-0.1.0.tar.gz"
  sha256 "a5bc9fa984f2c00ecffc71c87b69fd3f4d1a974f60eac79131f01481f3e19cc7"
  license "LicenseRef-CC-BY-NC-4.0"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "build", "--release", "--locked",
           "--bin", "imessage-analysis",
           "--bin", "imessage-mcp"
    bin.install "target/release/imessage-analysis"
    bin.install "target/release/imessage-mcp"
  end

  test do
    system "#{bin}/imessage-analysis", "--version"
  end
end
