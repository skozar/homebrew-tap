class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.9"
  url "https://github.com/skozar/keepalive/releases/download/v#{version}/keepalive-cli-#{version}.tar.gz"
  sha256 "17a120b8dd64760fb9d13b25f1f04fb7be8414dc67b73c198a9ee90acda9b482"

  def install
    # Tarball contains Contents/ from a PyInstaller --windowed .app bundle.
    # Homebrew unpacks and CDs into Contents/. Reconstruct the .app in libexec
    # so macOS identifies the process as "keepalive-cli" in Accessibility.
    app = libexec/"keepalive-cli.app"
    (app/"Contents").mkpath
    # Homebrew unpacks the tarball and CDs into the top-level dir (Contents/).
    # So CWD = staging/Contents/. Move everything from CWD into the .app.
    FileUtils.mv(Dir.children(Pathname.pwd), app/"Contents")

    # CLI symlink through .app
    # Note: codesign is done by `keepalive-cli setup` (runs outside Homebrew sandbox)
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end

  def caveats
    <<~EOS
      Run setup once to create a code signing certificate (needed for
      accessibility permissions to persist across brew upgrades):

        keepalive-cli setup

      To start the agent:
        keepalive-cli start

      Logs: ~/Library/Logs/keepalive/keepalive.log
    EOS
  end
end