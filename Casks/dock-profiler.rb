cask "dock-profiler" do
  version "1.8.0"
  sha256 "f870f9292502c750d74a3c5db5bd9e3a02b42fdfc1a0b7c54aeb7a66e99b8f52"

  url "https://github.com/estruyf/dock-profiler-macos/releases/download/v#{version}/DockProfiler-#{version}-macos-universal.zip"
  name "Dock Profiler"
  desc "Menu bar app for switching between Dock profiles, each with an optional desktop"
  homepage "https://github.com/estruyf/dock-profiler-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Dock Profiler.app"

  # It is a background app with no Dock icon, so an upgrade would otherwise
  # replace the bundle out from under a copy that is still running.
  uninstall quit: "dev.eliostruyf.DockProfiler"

  # Nothing here touches your actual Dock or Desktop settings — only what
  # Dock Profiler itself keeps: its saved profiles and its own preferences.
  zap trash: [
    "~/Library/Application Support/Dock Profiler",
    "~/Library/Preferences/dev.eliostruyf.DockProfiler.plist",
    "~/Library/Saved Application State/dev.eliostruyf.DockProfiler.savedState",
  ]
end
