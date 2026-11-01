cask "jfsecure" do
  arch arm: "arm64", intel: "x64"

  version "2.8.1"
  sha256 arm:   "29d98a1e12b467b59f1ebe9c5264223fa02cac18ba0dd990661b1c576f370153",
         intel: "1afcca3fd2d83d58576460a7ccb9977458716343f65e4c4e26e01df86c037a4d"

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
