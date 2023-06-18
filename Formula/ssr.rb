class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://github.com/SoundScapeRenderer/ssr/releases/download/0.6.0/ssr-0.6.0.tar.gz"
  sha256 "a7d48047e6bd884aa25ae9a96f97efa57aed26d65967ee5e56a13945f34d35e1"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/ssr-0.6.0_1"
    sha256 ventura:      "5822b0a131383ce054e97fb70e125af40b310fb9c4e69a71b403d2577c69213a"
    sha256 monterey:     "aeb6278431ba15f4ec022214219029ce333ee754ada3a4afd03b1eb9482026d9"
    sha256 big_sur:      "d03db02212cc9eb38d076b37d8e316b8158031b66dcfbb29492b355dacd6ddc6"
    sha256 x86_64_linux: "fb5389aa3059aead196c10c4b53582c53f660ace66d993ac23af9747b31e7154"
  end

  depends_on "pkg-config" => :build
  depends_on "asio"
  depends_on "ecasound"
  depends_on "fftw"
  depends_on "fmt"
  depends_on "jack"
  depends_on "libsndfile"
  depends_on "qt@5"
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
