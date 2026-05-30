class ImessageAnalysis < Formula
  desc "Extract, query, and analyse your Mac iMessage history"
  homepage "https://github.com/DecisionNerd/imessage-analysis"
  url "https://github.com/DecisionNerd/imessage-analysis/releases/download/v0.1.2/imessage-analysis-0.1.2.tar.gz"
  sha256 "6a0cd4aa1a13a3ef1f8b849815459402bf130424ba9b2adcfdc780b69da7f8b6"
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
