class Unsleep < Formula
  desc "Menu bar app and CLI that keeps your Mac awake, even with the lid closed"
  homepage "https://unsleep.lgtm.page"
  url "https://github.com/patsissons/unsleep/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "8548e1a44e64bb2e5c4d431b7d022150dee6e5733cfd0c9674f725e92a21704d"
  license "MIT"
  head "https://github.com/patsissons/unsleep.git", branch: "main"

  depends_on macos: :monterey

  def install
    # build.sh compiles with the Command Line Tools' swiftc; the CLI finds
    # the app beside its bin/ dir, so both stay in the keg.
    with_env(APPDIR: prefix.to_s, BINDIR: bin.to_s) do
      system "./build.sh"
    end
    pkgshare.install "install-sudoers.sh"
  end

  def caveats
    <<~EOS
      To open the menu bar app:
        open #{opt_prefix}/UnSleep.app
      or run `unsleep on`, which launches it as needed.

      To find it in Spotlight and Launchpad:
        ln -sf #{opt_prefix}/UnSleep.app ~/Applications/

      To skip the admin password on each toggle (password-free mode):
        sudo #{opt_pkgshare}/install-sudoers.sh
    EOS
  end

  service do
    # Through `open` so LaunchServices keeps a single instance of the app.
    run ["/usr/bin/open", "-g", opt_prefix/"UnSleep.app"]
  end

  test do
    assert_match "off (app not running)", shell_output("#{bin}/unsleep status")
    plist = prefix/"UnSleep.app/Contents/Info.plist"
    assert_equal version.to_s,
      shell_output("/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' #{plist}").strip
  end
end
