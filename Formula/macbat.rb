class Macbat < Formula
  desc "Sudoless power monitor TUI for Apple Silicon laptops"
  homepage "https://macbat.lgtm.page"
  url "https://github.com/patsissons/macbat/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9fc98dcee92a18d572ef7e5933178f3e978e2b4d8751d07b88fc09ee28bcb6d8"
  license "MIT"
  head "https://github.com/patsissons/macbat.git", branch: "main"

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macbat --version")
  end
end
