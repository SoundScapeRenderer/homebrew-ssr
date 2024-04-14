class Asdf < Formula
  desc "Library for loading Audio Scene Description Format (ASDF) files"
  homepage "https://github.com/AudioSceneDescriptionFormat/asdf-rust"
  url "https://github.com/AudioSceneDescriptionFormat/asdf-rust",
      using:    :git,
      tag:      "1.0.0",
      revision: "ee6147b4d89c18fcc48fd1ae3a7967e6a5ea3cc0"
  license any_of: ["MIT", "Apache-2.0"]
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/asdf-1.0.0"
    sha256 cellar: :any,                 ventura:      "a226fc5746790a4b03e4b5c62d09cc257dc2ad206ed55c10c61e41b35cacbeb8"
    sha256 cellar: :any,                 monterey:     "a08653b4c37a0a8ae5faa4bf1ff5a387b897f01860585c0011701070680cc9cf"
    sha256 cellar: :any,                 big_sur:      "6b2ff47ae964257292e91f1eca0c54100073ce1f6f8662e86d9d372b1f943075"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "84c61c0137625bbe6e2beac62b2ce85558eedca9810b0e56cd5c074882836626"
  end

  depends_on "cargo-c" => :build
  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "cinstall", "--prefix", prefix
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <asdf.h>

      int main(void)
      {
        const char* error = asdf_last_error();
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lasdf", "-o", "test"
    system "./test"
  end
end
