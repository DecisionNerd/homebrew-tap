class ImessageAnalysis < Formula
  desc "Extract, query, and analyse your Mac iMessage history"
  homepage "https://github.com/DecisionNerd/imessage-analysis"
  url "https://github.com/DecisionNerd/imessage-analysis/releases/download/v0.1.3/imessage-analysis-0.1.3.tar.gz"
  sha256 "d8947b42534c7fdd60533cb3e8cde0f8ff80e174e1df78577f53c990960057d1"
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
