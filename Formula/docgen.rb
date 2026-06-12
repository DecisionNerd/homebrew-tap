class Docgen < Formula
  desc "Scaffold a standardized, BDD-oriented docs/ tree for AI agents to fill in"
  homepage "https://github.com/DecisionNerd/docgen"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.2.0/docgen-aarch64-apple-darwin.tar.xz"
      sha256 "c2aa174a60b37b79628043362a8e5e0b9c59e75448cf7093253ddbc411838c55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.2.0/docgen-x86_64-apple-darwin.tar.xz"
      sha256 "7734bd368e10c37d3369245ceac3d1a5a2e918df2f967aa0eb060cc61e48fad5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.2.0/docgen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b3f3a902a93c4cd9d4a515069802657e8685586cb6f69cdc70d6299a6898cd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.2.0/docgen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8a5a12001ead538cefe42a03b6a8c8868444100dbe36e08f4b0ae063fdd2730"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "docgen" if OS.mac? && Hardware::CPU.arm?
    bin.install "docgen" if OS.mac? && Hardware::CPU.intel?
    bin.install "docgen" if OS.linux? && Hardware::CPU.arm?
    bin.install "docgen" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
