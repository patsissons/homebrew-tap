cask "unsleep" do
  version "1.2.0"
  sha256 "3d6b2e21f605b6e80281e0af72c87d92633a4ea28790cf8cdfdcc4342fa01700"

  url "https://github.com/patsissons/unsleep/releases/download/v#{version}/UnSleep-#{version}.zip"
  name "UnSleep"
  desc "Menu bar app and CLI that keeps the computer awake, even with the lid closed"
  homepage "https://unsleep.lgtm.page/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "UnSleep.app"
  binary "#{appdir}/UnSleep.app/Contents/Helpers/unsleep"

  # UnSleep is ad-hoc signed, not notarized, so Gatekeeper would refuse to run
  # both the app and its CLI. Drop the download quarantine so they run like a
  # locally built copy.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/UnSleep.app"],
        writable_paths: "UnSleep.app",
        writable_base:  :appdir
  end

  # Quitting restores the sleep settings UnSleep changed.
  uninstall quit: "com.patsissons.UnSleep"

  zap delete: "/etc/sudoers.d/unsleep",
      trash:  [
        "~/Library/Application Support/UnSleep",
        "~/Library/Preferences/com.patsissons.UnSleep.plist",
      ]
end
