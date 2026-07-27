class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///Users/skozar/Projects/pets/keepalive/dist/keepalive-test.tar.gz"
  sha256 "b415dd1b6ed9016f0709b13d24af01bf5605f7376cc860f5a7630d8fc4f9f1fb"

  def install
    libexec.install Dir["*"]
    FileUtils.mv(libexec/"keepalive-app-bundle", libexec/"keepalive-cli.app")
    bin.install_symlink libexec/"keepalive-cli.app/Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
