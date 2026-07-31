class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.9"
  url "https://github.com/skozar/keepalive/releases/download/v#{version}/keepalive-cli-#{version}.tar.gz"
  sha256 "1bbd4d09d83253ad09c3f3a74ad5f5dbdd01318d75e971339a1ed6745408b70f"

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