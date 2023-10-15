class Ssr < Formula
  desc "SoundScape Renderer: A tool for real-time spatial audio reproduction"
  homepage "http://spatialaudio.net/ssr/"
  url "https://output.circle-artifacts.com/output/job/24c2adaf-bd86-435a-8067-da4f0fc0216e/artifacts/0/ssr-0.5.0-314-g7ce5325.tar.gz"
  sha256 "217fdd5564e3e6756c81891bc369da7e95df3f550f9d76732c5fbbbe15bb508b"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/ssr-0.6.1"
    sha256 ventura:      "4fdb88444b92087347d68707636162a3530121cc8945b7956b582e8ba6362619"
    sha256 monterey:     "2034c7cedad4385db58d24a245b1f6aa0bc35c859b94f6c09b09f23b36e1240c"
    sha256 big_sur:      "4e97b8bfcb13e575ad4a37662a7e04aeee0cc6130691c1d39df9d2bdff417a4b"
    sha256 x86_64_linux: "383ebd444df15c810c06c03c01be489916e79e0b8ca9007ebe205d244fee8f22"
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
