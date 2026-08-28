cask "linklane" do
  version "0.2.0"
  sha256 "37dd067999e96b7d17384a94c92988be02de2e841f780e35fd9121d430871d7b"

  url "https://github.com/estruyf/LinkLane/releases/download/v#{version}/LinkLane_#{version}_aarch64.dmg"
  name "LinkLane"
  desc "Browser picker that routes every link to the browser you choose"
  homepage "https://github.com/estruyf/LinkLane"

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

  app "LinkLane.app"

  # LinkLane is a menu bar app with no Dock icon, and macOS keeps the default
  # browser handler running, so an upgrade would otherwise replace the bundle
  # out from under a copy that is still open.
  uninstall quit: "com.eliostruyf.linklane"

  # settings.json (browser order, hidden browsers, hotkeys, picker height) is
  # the only thing here the app itself wrote; the rest is macOS scratch space
  # for the bundle identifier.
  zap trash: [
    "~/Library/Application Support/com.eliostruyf.linklane",
    "~/Library/Caches/com.eliostruyf.linklane",
    "~/Library/Logs/com.eliostruyf.linklane",
    "~/Library/Saved Application State/com.eliostruyf.linklane.savedState",
    "~/Library/WebKit/com.eliostruyf.linklane",
  ]
end
