cask "jfsecure" do
  arch arm: "arm64", intel: "x64"

  version "2.6.0"
  sha256 arm:   "d3376302a5061b27c4227876c070af2261013da98aa5dff8e23cd801f69964aa",
         intel: "726f054ed2c333b5c5bf70233ca5e5de1d9629c4f8c038e45cb7d2d26c33b715"

  url "https://secure.jfolio.org/api/updates/download/#{version}/mac-#{arch}?src=brew"
  name "JFSecure"
  desc "Secrets and snippets at a global hotkey, with an offline deniable vault"
  homepage "https://secure.jfolio.org/"

  livecheck do
    url "https://secure.jfolio.org/api/updates/latest?platform=mac&arch=arm64"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "JFSecure.app"
  binary "#{appdir}/JFSecure.app/Contents/MacOS/jfs"

  # not signed by Apple: without this macOS refuses to open it ("damaged")
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/JFSecure.app"]
  end

  caveats <<~EOS
    JFSecure is not signed by Apple; the quarantine flag was removed on install.
    For auto-paste, allow JFSecure in System Settings → Privacy & Security → Accessibility.
    Vaults live in ~/Library/Application Support/JFSecure and are kept on uninstall.
  EOS
end
