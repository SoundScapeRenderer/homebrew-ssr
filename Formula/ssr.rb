class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://output.circle-artifacts.com/output/job/ce69ac4a-9930-404f-b9b1-5db5b111f6d6/artifacts/0/ssr-0.6.0-44-g147fd80.tar.gz"
  version "0.6.0.1"
  sha256 "4c14fbaafac41da0d19e9715cc6bedfd360a1ae8b4a7f5a763dc9096a435cd10"
  license "GPL-3.0-or-later"

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
