cask "switchboard" do
  version "0.0.10"
  sha256 "23983a2f2511c45cfc4eceabef739a134470061c9ffac38b59cecde2f899b7a7"

  url "https://github.com/estruyf/switchboard/releases/download/v#{version}/Switchboard-#{version}-arm64-mac.zip"
  name "Switchboard"
  desc "Desktop app for managing Claude Code sessions"
  homepage "https://github.com/estruyf/switchboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Switchboard updates itself from the release feed, so `brew upgrade` leaves it alone rather than
  # race the in-app updater. The tap still moves on every release, which is what `--greedy` and a
  # fresh `brew install` read.
  # Only an Apple Silicon build is released, and LSMinimumSystemVersion is 13.0 (Electron's floor).
  # The in-app updater has no floor of its own, so `macos` has to move whenever Electron's does.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Switchboard.app"

  # An upgrade would otherwise replace the bundle under a copy that is still running.
  uninstall quit: "dev.switchboard.app"

  # Switchboard's own files only. Sessions live in ~/.claude, which belongs to Claude Code, so
  # `brew uninstall --zap` never touches them.
  zap trash: [
    "~/Library/Application Support/Switchboard",
    "~/Library/Caches/@switchboarddesktop-updater",
    "~/Library/Caches/dev.switchboard.app",
    "~/Library/Caches/dev.switchboard.app.ShipIt",
    "~/Library/HTTPStorages/dev.switchboard.app",
    "~/Library/Preferences/dev.switchboard.app.plist",
    "~/Library/Saved Application State/dev.switchboard.app.savedState",
  ]
end
