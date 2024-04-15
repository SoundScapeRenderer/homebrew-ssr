class Libmysofa < Formula
  desc "Reader for AES SOFA files to get better HRTFs"
  homepage "https://github.com/hoene/libmysofa"
  url "https://github.com/hoene/libmysofa/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "6c5224562895977e87698a64cb7031361803d136057bba35ed4979b69ab4ba76"
  license "BSD-3-Clause"
  revision 1

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/libmysofa-1.3.2_1"
    sha256 arm64_sonoma: "dea4a65152cefe254ac899e2c231997d1bd36b9c0f7fbbaf82fa546a054ea448"
    sha256 ventura:      "d4bbb3b83899ec1dc0a9dbc64e316b60157b30a57b783f3fd7942df7252cc676"
    sha256 monterey:     "1fd5d86b7916a68d48aa913c6d29489e8e58e09e0ff2fd724117c530b4676b67"
    sha256 x86_64_linux: "f02ff73b9886d8e1a5afd2e873d323de121ca394722a505e741455bf117ee9de"
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
