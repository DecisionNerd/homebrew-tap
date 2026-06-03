class Docgen < Formula
  desc "Scaffold a standardized, BDD-oriented docs/ tree into a git repo, with templates designed for AI agents to fill in."
  homepage "https://github.com/DecisionNerd/docgen"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.1.0/docgen-aarch64-apple-darwin.tar.xz"
      sha256 "a8d1b404ee49193787a644945525e1b79e79aaa6fd2c01e89fd332eff8fb76a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.1.0/docgen-x86_64-apple-darwin.tar.xz"
      sha256 "bbc0ff5ef9e8e455bac2faa2c313e8b15319e4c25d02a92a49294b45c8d07777"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.1.0/docgen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5567e58cd076c3ba3b0164668e96e6e99a44bbb8418bf02a33196cfbc781e87c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DecisionNerd/docgen/releases/download/v0.1.0/docgen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "144c8300ed2cf83284a18f221fdc6187273a57fe549b230f20aa82ec7f0fadcb"
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
