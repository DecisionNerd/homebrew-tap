class Docslime < Formula
  desc "Opinionated DocSlime docs scaffolding for AI agents, TDD+BDD, DDD, and ADRs"
  homepage "https://docmd.io"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/DocSlime/releases/download/v0.3.0/docslime-aarch64-apple-darwin.tar.xz"
      sha256 "ac0a366e34fc0dbaaabc2c7bcbe20b8906216fe73a073c283f6af47ac2815677"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/DocSlime/releases/download/v0.3.0/docslime-x86_64-apple-darwin.tar.xz"
      sha256 "e23101dcc2e3b6b6c8612b3887f20d93cc5a71a2381d163b0c082d566c4db80a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/DocSlime/releases/download/v0.3.0/docslime-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d19e7df7959f950528c0fddb2c7a7643f5db9684306317621cdaf1d7f5c5e83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/DocSlime/releases/download/v0.3.0/docslime-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1877c1a9c297191b49ce5ff7b223867649efd3846540c7aedf06cca9fd41c8c4"
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
    bin.install "docslime" if OS.mac? && Hardware::CPU.arm?
    bin.install "docslime" if OS.mac? && Hardware::CPU.intel?
    bin.install "docslime" if OS.linux? && Hardware::CPU.arm?
    bin.install "docslime" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
