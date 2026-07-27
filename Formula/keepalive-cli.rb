class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///Users/skozar/Projects/pets/keepalive/dist/keepalive-flat.tar.gz"
  sha256 "80ace24d7112559a93f198fbf04de884583893e978417239b4a17d0052d26531"

  def install
    # Create .app bundle from flat tarball contents
    app = libexec/"keepalive-cli.app"
    app.mkpath
    # Move extracted Contents/ into the .app
    FileUtils.mv(Dir["*"].map { |f| Pathname(f) }, app)
    
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
