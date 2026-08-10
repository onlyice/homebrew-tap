cask "agent-sessions" do
  arch arm: "arm64", intel: "x64"

  version "1.10.0"
  sha256 arm:   "PLACEHOLDER_ARM",
         intel: "PLACEHOLDER_INTEL"

  url "https://github.com/onlyice/agent-sessions/releases/download/v#{version}/Agent.Sessions-#{version}-#{arch}.dmg"
  name "Agent Sessions"
  desc "Browse, search and resume coding agent sessions"
  homepage "https://github.com/onlyice/agent-sessions"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Agent Sessions.app"

  # The app is ad-hoc signed and not notarized, so the quarantine attribute
  # Homebrew sets on download would make Gatekeeper refuse to launch it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Agent Sessions.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/agent-session-list",
    "~/Library/Preferences/io.zhiheng.agent-sessions.plist",
    "~/Library/Saved Application State/io.zhiheng.agent-sessions.savedState",
  ]
end
