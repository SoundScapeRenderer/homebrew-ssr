class Libmysofa < Formula
  desc "Reader for AES SOFA files to get better HRTFs"
  homepage "https://github.com/hoene/libmysofa"
  url "https://github.com/hoene/libmysofa/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "6c5224562895977e87698a64cb7031361803d136057bba35ed4979b69ab4ba76"
  license "BSD-3-Clause"
  revision 3

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/libmysofa-1.3.2_3"
    sha256 arm64_sequoia: "86417b9687037dcb33b3385efa9f75811dc245cedb477edf42c94382ac649c65"
    sha256 arm64_sonoma:  "40a6a7ae843b9af5dbc9844aa4f7715091b60081b2e98b52d03ecf798a93facd"
    sha256 sequoia:       "d9f2948d68f647934e5f068b8ab5c2a955eb3e15a403de1d502cbac4e2b26a6b"
  end

  depends_on "cmake" => :build

  uses_from_macos "zlib"

  def install
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-D BUILD_TESTS=OFF"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <mysofa.h>

      int main(void)
      {
        char buffer[9] = "TESTDATA";
        int filter_length;
        int err;
        struct MYSOFA_EASY *hrtf = NULL;
        hrtf = mysofa_open_data(buffer, 9, 48000, &filter_length, &err);
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lmysofa", "-o", "test"
    system "./test"
  end
end
