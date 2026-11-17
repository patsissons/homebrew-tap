class Macbat < Formula
  desc "Sudoless power monitor TUI for Apple Silicon laptops"
  homepage "https://macbat.lgtm.page"
  url "https://github.com/patsissons/macbat/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d8e2150981c3c1b0a34348f6b09f5d0f5e6d3d24688e1208905a94d928b525ec"
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
