class Libmysofa < Formula
  desc "Reader for AES SOFA files to get better HRTFs"
  homepage "https://github.com/hoene/libmysofa"
  url "https://github.com/hoene/libmysofa/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "a8a8cbf7b0b2508a6932278799b9bf5c63d833d9e7d651aea4622f3bc6b992aa"
  license "BSD-3-Clause"
  revision 2

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/libmysofa-1.3.1_1"
    sha256 monterey:     "c2a83981ecc01748e5e0eb90fd2b26efc5d916704bda7890fac76b87ac168918"
    sha256 big_sur:      "f2d922123a0fd69690da22053f770021c3a4bd37ca836ccab6405d4a99f7233f"
    sha256 x86_64_linux: "973d11130f7f3ddd00974931b5d3ea258e9b502977655b63d76f54f7d92b4c81"
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
