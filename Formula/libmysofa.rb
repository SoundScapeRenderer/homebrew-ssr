class Libmysofa < Formula
  desc "Reader for AES SOFA files to get better HRTFs"
  homepage "https://github.com/hoene/libmysofa"
  url "https://github.com/hoene/libmysofa/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "6c5224562895977e87698a64cb7031361803d136057bba35ed4979b69ab4ba76"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/libmysofa-1.3.2"
    sha256 ventura:      "ca6327ed10d79980c9805819fca305b243453cefc38539fcb160bed0488265aa"
    sha256 monterey:     "ffda54674d633349c60d31bbf1622c4454ace4769fbb5ac20a989123e6e035f5"
    sha256 x86_64_linux: "6ca07fac392340cd4c3b6ddbfc3c9f5698efe4279602b75291d87032e8c816c3"
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
