class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://github.com/SoundScapeRenderer/ssr/releases/download/0.6.0/ssr-0.6.0.tar.gz"
  sha256 "a7d48047e6bd884aa25ae9a96f97efa57aed26d65967ee5e56a13945f34d35e1"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/ssr-0.6.0"
    sha256 monterey:     "0ddd24ae5109bfcd4872302fadac5c6cfe61c96fc265c9a77353e7050fac13c0"
    sha256 big_sur:      "3b82c1b0dd833d8ab20e1b39a7c9f2c5b88503009e40d83637521a4a601b58bb"
    sha256 x86_64_linux: "06e98b2218dab493659599dd7416694d81e319e1cf7374718e47cb6dc665681c"
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
