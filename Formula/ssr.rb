class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://github.com/SoundScapeRenderer/ssr/releases/download/0.6.1/ssr-0.6.1.tar.gz"
  sha256 "392a13ecbf86f980be76a31884a83ab762e577c1c829cb5e744f708542bc5bdb"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/ssr-0.6.1_1"
    sha256 arm64_sonoma: "38274cad8a6798238aeaca41cd7a1f083838de15f9d9d72ee732d89b0522bb79"
    sha256 ventura:      "0abafbdcdcb27080aded1a325243052f55de2343b5a160593b9b8d6900453da2"
    sha256 monterey:     "8feb39fb7898e9c770a17080eb368dfd45b26aedf337ac9396e5382c29339e3a"
    sha256 x86_64_linux: "3fbf3bd50726f0fa9a40e8e9c98c25e14814e1000b279700532fce81d5e57760"
  end

  depends_on "pkg-config" => :build
  depends_on "asio"
  depends_on "ecasound"
  depends_on "fftw"
  depends_on "fmt" => "10.2.1"
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
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include/libecasoundc"
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
