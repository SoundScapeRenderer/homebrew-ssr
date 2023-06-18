class Libmysofa < Formula
  desc "Reader for AES SOFA files to get better HRTFs"
  homepage "https://github.com/hoene/libmysofa"
  url "https://github.com/hoene/libmysofa/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "a8a8cbf7b0b2508a6932278799b9bf5c63d833d9e7d651aea4622f3bc6b992aa"
  license "BSD-3-Clause"
  revision 3

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/libmysofa-1.3.1_3"
    sha256 ventura:      "293fc53e4e1b15aaf947bcdd64ed330271eb8ef093764335ea7926e22efefd30"
    sha256 monterey:     "96ac387456ee448b1f3f7cad717493709a4ffc6125e7f5b1d1d3d57d0277094c"
    sha256 big_sur:      "304c62ba8989426a240b4ce6c8b81d46b298f10a4c24e268c4c1f0a2a93751d4"
    sha256 x86_64_linux: "aef94e3c97c341f408e026961062f6ed9f69f2269d7ff9e74eaefb656f0c98de"
  end

  depends_on "cmake" => :build

  uses_from_macos "zlib"

  def install
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
