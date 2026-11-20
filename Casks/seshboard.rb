cask "seshboard" do
  version "1.4.0"
  sha256 "9f87295b17cb503dc265815d224b6e93b52e563d511ce46c2251010e85c9374c"

  url "https://github.com/estruyf/seshboard/releases/download/v#{version}/Seshboard-#{version}-arm64-mac.zip"
  name "Seshboard"
  desc "Desktop app for managing Claude Code sessions"
  homepage "https://github.com/estruyf/seshboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Seshboard updates itself from the release feed, so `brew upgrade` leaves it alone rather than
  # race the in-app updater. The tap still moves on every release, which is what `--greedy` and a
  # fresh `brew install` read.
  # Only an Apple Silicon build is released, and LSMinimumSystemVersion is 13.0 (Electron's floor).
  # The in-app updater has no floor of its own, so `macos` has to move whenever Electron's does.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Seshboard.app"

  # An upgrade would otherwise replace the bundle under a copy that is still running.
  uninstall quit: "dev.switchboard.app"

  # Seshboard's own files only, also under its name before the rename (Switchboard). Sessions live
  # in ~/.claude, which belongs to Claude Code, so `brew uninstall --zap` never touches them.
  zap trash: [
    "~/Library/Application Support/Seshboard",
    "~/Library/Application Support/Switchboard",
    "~/Library/Caches/@seshboarddesktop-updater",
    "~/Library/Caches/@switchboarddesktop-updater",
    "~/Library/Caches/dev.switchboard.app",
    "~/Library/Caches/dev.switchboard.app.ShipIt",
    "~/Library/HTTPStorages/dev.switchboard.app",
    "~/Library/Preferences/dev.switchboard.app.plist",
    "~/Library/Saved Application State/dev.switchboard.app.savedState",
  ]
end
