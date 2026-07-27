class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///tmp/keepalive-test.tar.gz"
  sha256 "4f6be1d10fc632671f9dab091cc4075bda753db4c192fca167dee04e966f2b45"

  def install
    # Homebrew unpacks the tarball and CDs into the top-level directory.
    # Our tarball contains Contents/ at the top level, so CWD = Contents/.
    # Install everything into .app/Contents/
    app = libexec/"keepalive-cli.app"
    (app/"Contents").mkpath
    FileUtils.mv(Dir["*"], app/"Contents", verbose: true)
    
    system "codesign", "--force", "--deep", "--sign", "-", app.to_s
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
