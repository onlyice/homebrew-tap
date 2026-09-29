cask "agent-sessions" do
  arch arm: "arm64", intel: "x64"

  version "1.11.2"
  sha256 arm:   "a404d63e1612dcd22e621b184cc21254a4bde0862bb9a18023c61ec97627330e",
         intel: "d554c4eae687d3b62062953acc4a7aa748c0a38523bcc720dc9f3c2b70ba0629"

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
