class Macbat < Formula
  desc "Sudoless power monitor TUI for Apple Silicon laptops"
  homepage "https://macbat.lgtm.page"
  url "https://github.com/patsissons/macbat/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "9e31cee00028a6b24410ae4f8704ca64f622fb0bbb48e2b876af2ac9612ea886"
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
