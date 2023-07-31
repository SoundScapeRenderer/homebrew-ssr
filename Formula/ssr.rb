class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://output.circle-artifacts.com/output/job/935a8b96-f52a-4284-b016-b9291b1278a8/artifacts/0/ssr-0.6.1-52-g1dcd55e.tar.gz"
  version "0.6.1.1"
  sha256 "c79c8e792d8370f64affea60750482bb395d22afe162def18cebc79515798af9"
  license "GPL-3.0-or-later"

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
