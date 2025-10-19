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
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/asdf-1.1.0"
    sha256 cellar: :any, arm64_sequoia: "cfe97183174631453fcc1ab4017ce05b7e88ffcb1f5adae946e37fab428f6231"
    sha256 cellar: :any, arm64_sonoma:  "e4381db70b22729ce5dd83d4f9b3cf625633314b5201061df09e0d6ea0e3aed3"
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
