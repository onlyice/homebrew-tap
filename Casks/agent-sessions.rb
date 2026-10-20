cask "agent-sessions" do
  arch arm: "arm64", intel: "x64"

  version "1.12.0"
  sha256 arm:   "ce30e2ea49102ad6b927a50baaee9de3b6018e40883f105d504df418cd6806db",
         intel: "910df6f4ccbd262d4c3b21ee30a69d9511f27b6f011f532f5482fe5975597f4a"

  url "https://github.com/onlyice/agent-sessions/releases/download/v#{version}/Agent.Sessions-#{version}-#{arch}.dmg"
  name "Agent Sessions"
  desc "Browse, search and resume coding agent sessions"
  homepage "https://github.com/onlyice/agent-sessions"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Agent Sessions.app"

  # The app is ad-hoc signed and not notarized, so the quarantine attribute
  # Homebrew sets on download would make Gatekeeper refuse to launch it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Agent Sessions.app"]
  end

  zap trash: [
    "~/Library/Application Support/agent-session-list",
    "~/Library/Preferences/io.zhiheng.agent-sessions.plist",
    "~/Library/Saved Application State/io.zhiheng.agent-sessions.savedState",
  ]
end
