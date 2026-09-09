cask "agent-sessions" do
  arch arm: "arm64", intel: "x64"

  version "1.11.1"
  sha256 arm:   "c66b209c416578f91d108c83d06f0991a6ad5ab85dae34ce0374062160fd7642",
         intel: "ab9ce3f544ee8fe48b71b2da4ad2d0f3012b1bb8ecf69f55007cc50c516e6997"

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
