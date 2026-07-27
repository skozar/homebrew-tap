class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///tmp/keepalive-test.tar.gz"
  sha256 "4f6be1d10fc632671f9dab091cc4075bda753db4c192fca167dee04e966f2b45"

  def install
    app = libexec/"keepalive-cli.app"
    (app/"Contents").mkpath
    Pathname("Contents").children.each do |child|
      FileUtils.mv(child, app/"Contents")
    end
    system "codesign", "--force", "--deep", "--sign", "-", app.to_s
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
