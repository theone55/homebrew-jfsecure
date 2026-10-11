cask "jfsecure" do
  arch arm: "arm64", intel: "x64"

  version "2.6.2"
  sha256 arm:   "e09701b441f2c7fd7f3c69c8be927b596310c00a24b781ccc3acef440e7b9176",
         intel: "7a65a8e44146cbd0bc2fced9f8e5b71dd6b3069dd5c839f98074571cc0434d6c"

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
