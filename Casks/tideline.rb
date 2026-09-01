cask "tideline" do
  version "1.13.0"
  sha256 "64eabd9b5117ab8ec6ac8a9c6825ad7e4744e8bf28fe7e94e9c4b8e5a7ddd435"

  url "https://github.com/estruyf/tideline/releases/download/v#{version}/Tideline-#{version}-macos-universal.zip"
  name "Tideline"
  desc "Menu bar app that files older downloads into folders by arrival date"
  homepage "https://github.com/estruyf/tideline"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Tideline looks for a newer release once a day and installs it itself, so
  # `brew upgrade` should leave it alone rather than race the in-app updater.
  # The tap still moves on every release, which is what `--greedy` and a fresh
  # `brew install` read.
  auto_updates true

  # The in-app updater has no floor of its own, so this is the only thing
  # standing between someone on macOS 13 and a bundle that will not launch.
  depends_on macos: :sonoma

  app "Tideline.app"

  # It is a background app with no Dock icon, so an upgrade would otherwise
  # replace the bundle out from under a copy that is still running.
  uninstall quit: "be.eliostruyf.Tideline"

  # The same three paths the app's own Uninstall sheet names. Nothing here is
  # in the Downloads folder: `brew uninstall --zap` removes Tideline, never
  # anything Tideline filed.
  zap trash: [
    "~/Library/Application Support/Tideline",
    "~/Library/Logs/Tideline.log",
    "~/Library/Preferences/be.eliostruyf.Tideline.plist",
  ]
end
