cask "jfsecure" do
  arch arm: "arm64", intel: "x64"

  version "2.6.1"
  sha256 arm:   "7911cf3ec38e3bcc757cdcfc783e484cddfec64b1135158344873b2450686003",
         intel: "8683973420bd8938c92d4c362db83d21564e50e3e94021bdf06bf0ace78bdd43"

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
