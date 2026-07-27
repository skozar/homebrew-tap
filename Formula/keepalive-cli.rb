class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///Users/skozar/Projects/pets/keepalive/dist/keepalive-flat2.tar.gz"
  sha256 "0757546e7935e385559deda60ff1a2277c504601da0f7f534f9678ee345c2f8a"

  def install
    # Create .app bundle and install Contents/ into it
    app = libexec/"keepalive-cli.app"
    app.mkpath
    (app/"Contents").mkpath
    # Move extracted Contents/ items into .app/Contents/
    contents_dir = Pathname("Contents")
    FileUtils.mv(contents_dir.children, app/"Contents")
    
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
