class Asdf < Formula
  desc "Library for loading Audio Scene Description Format (ASDF) files"
  homepage "https://github.com/AudioSceneDescriptionFormat/asdf-rust"
  url "https://github.com/AudioSceneDescriptionFormat/asdf-rust",
      using:    :git,
      tag:      "1.1.0",
      revision: "6b31ccb9cb040e357236723d9dc78b7bf89c1411"
  license any_of: ["MIT", "Apache-2.0"]
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/asdf-1.1.0_1"
    sha256 cellar: :any, arm64_sequoia: "81e5b9ac33a4a505940b3e72a1222c4fab4817b9f795897bb745c992dfc7ccd8"
    sha256 cellar: :any, arm64_sonoma:  "9705d6acc5a41e57c14dd469983a24b0a7e7d896b53f9d951ba1a1c9fc8df11a"
  end

  depends_on "cargo-c" => :build
  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    # for libsamplerate-sys v0.1.12, https://github.com/Prior99/libsamplerate-sys/issues/21:
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"
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
