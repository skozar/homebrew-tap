class KeepaliveCli < Formula
  desc "Keep macOS awake for Teams during chosen hours"
  homepage "https://github.com/skozar/keepalive"
  version "0.11.4"
  url "file:///tmp/keepalive-test.tar.gz"
  sha256 "4f6be1d10fc632671f9dab091cc4075bda753db4c192fca167dee04e966f2b45"

  def install
    ohai "CWD: #{Dir.pwd}"
    ohai "Dir entries: #{Dir['*'].inspect}"
    
    app = libexec/"keepalive-cli.app"
    (app/"Contents").mkpath
    
    # Find the Contents directory (could be at root of staging)
    contents_dir = Dir.children(".").find { |f| f == "Contents" }
    ohai "Contents dir found: #{contents_dir}"
    
    if contents_dir
      FileUtils.mv(Pathname.new(contents_dir).children, app/"Contents")
    else
      # Fallback: install everything and find Contents
      libexec.install Dir["*"]
      ohai "Libexec contents: #{libexec.children.inspect}"
      src = libexec/"Contents"
      if src.exist?
        FileUtils.mv(src.children, app/"Contents")
      end
    end
    
    system "codesign", "--force", "--deep", "--sign", "-", app.to_s
    bin.install_symlink app/"Contents/MacOS/keepalive-cli" => "keepalive-cli"
  end
end
