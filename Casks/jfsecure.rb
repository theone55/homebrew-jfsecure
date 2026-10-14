cask "jfsecure" do
  arch arm: "arm64", intel: "x64"

  version "2.6.3"
  sha256 arm:   "b6c568cd44948c063c9e6048a233b8beef25bbf37e5172d2d4ed71cd228487b9",
         intel: "78c86d432dcc788214258ab1c6c942cb007519c9f2072aabbb144d396c3037c7"

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
