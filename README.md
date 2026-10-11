# Homebrew tap for JFSecure

[JFSecure](https://secure.jfolio.org/) — secrets and snippets at a global hotkey, with an offline deniable vault.

```sh
brew install theone55/jfsecure/jfsecure
```

Installs `JFSecure.app` and the `jfs` command. The app is not signed by Apple; the cask removes the
quarantine flag after install. The app updates itself (or `brew upgrade jfsecure`).
Vaults live in `~/Library/Application Support/JFSecure` and are kept on uninstall.

This repo holds only the cask; it is updated automatically by each JFSecure release.
