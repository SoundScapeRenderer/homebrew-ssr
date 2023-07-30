class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://github.com/SoundScapeRenderer/ssr/releases/download/0.6.1/ssr-0.6.1.tar.gz"
  sha256 "392a13ecbf86f980be76a31884a83ab762e577c1c829cb5e744f708542bc5bdb"
  license "GPL-3.0-or-later"
  revision 2

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/ssr-0.6.1_2"
    sha256 arm64_sonoma: "5098999078a70c4d9f8ecd82ed808600bef1cab6ad16bcc3f6e160de8c39b868"
    sha256 ventura:      "cff81d327eafb7e36cc14b79f2fb16b629b50b6f6453c6d44b55613d06a61da0"
    sha256 x86_64_linux: "af163ad5ce326484672f6c1cc684f44b815875cfbff403ab897140e498d1f99b"
  end

  depends_on "pkg-config" => :build
  depends_on "asio"
  depends_on "ecasound"
  depends_on "fftw"
  depends_on "fmt"
  depends_on "jack"
  depends_on "libsndfile"
  depends_on "qt@5"
  depends_on "SoundScapeRenderer/ssr/asdf"
  depends_on "SoundScapeRenderer/ssr/libmysofa"
  depends_on "vrpn"
  depends_on "websocketpp"

  on_linux do
    depends_on "mesa-glu"
  end

  def install
    # Make sure all expected features are switched on:
    features = %w[
      --enable-browser-gui
      --enable-dynamic-asdf
      --enable-ecasound
      --enable-fudi-interface
      --enable-gui
      --disable-intersense
      --enable-ip-interface
      --enable-polhemus
      --enable-razor
      --enable-sofa
      --enable-vrpn
      --enable-websocket-interface
    ]
    system "./configure", *std_configure_args, "--disable-silent-rules", *features
    system "make", "install"
  end

  test do
    # Not a great test, but it's hard to actually run the SSR in this context
    assert_match "Usage", shell_output("#{bin}/ssr-binaural --help")
  end
end
