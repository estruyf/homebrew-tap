cask "bingscape" do
  version "0.2.0"
  sha256 "c9d27dd2554b7af5920cde4824a9a879d796dc049a675f578f789c76d088eba8"

  url "https://github.com/estruyf/bingscape-tauri/releases/download/v#{version}/Bingscape_#{version}_aarch64.dmg"
  name "Bingscape"
  desc "Sets the daily Bing image as your desktop wallpaper"
  homepage "https://github.com/estruyf/bingscape-tauri"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The release job builds aarch64-apple-darwin only, so there is no bundle to
  # hand an Intel Mac. Without this, `brew install` would fail on the download
  # instead of saying why.
  depends_on arch: :arm64
  # A bare symbol is a minimum, and every Apple Silicon Mac ships Big Sur or
  # later, so this is the floor the arch line above already implies.
  depends_on macos: :big_sur

  app "Bingscape.app"

  # "Start at login" writes ~/Library/LaunchAgents/Bingscape.plist, labelled
  # after the app rather than the bundle id, pointing at the very path this
  # cask installs to. Unloading it first stops launchd relaunching a bundle
  # that is being replaced or removed. Bingscape also runs without a Dock
  # icon, so an upgrade would otherwise swap it out from under a live copy.
  uninstall launchctl: "Bingscape",
            quit:      "com.eliostruyf.Bingscape"

  # settings.json is the app's own preferences; the cache is where it keeps
  # the downloaded Bing images. Nothing here touches a wallpaper macOS has
  # already been told to use.
  zap trash: [
    "~/Library/Application Support/com.eliostruyf.Bingscape",
    "~/Library/Caches/com.eliostruyf.Bingscape",
    "~/Library/LaunchAgents/Bingscape.plist",
    "~/Library/Saved Application State/com.eliostruyf.Bingscape.savedState",
    "~/Library/WebKit/com.eliostruyf.Bingscape",
  ]
end
