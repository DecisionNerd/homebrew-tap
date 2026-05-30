class ImessageAnalysis < Formula
  desc "Extract, query, and analyse your Mac iMessage history"
  homepage "https://github.com/DecisionNerd/imessage-analysis"
  url "https://github.com/DecisionNerd/imessage-analysis/releases/download/v0.1.1/imessage-analysis-0.1.1.tar.gz"
  sha256 "9631c7c2d0e7a1042becb6cde57deaf322163791632b4670d3b63d71faa92b26"
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
