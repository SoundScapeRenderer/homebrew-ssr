class Asdf < Formula
  desc "Library for loading Audio Scene Description Format (ASDF) files"
  homepage "https://github.com/AudioSceneDescriptionFormat/asdf-rust"
  url "https://github.com/AudioSceneDescriptionFormat/asdf-rust",
      using:    :git,
      tag:      "1.1.0",
      revision: "6b31ccb9cb040e357236723d9dc78b7bf89c1411"
  license any_of: ["MIT", "Apache-2.0"]

  bottle do
    root_url "https://github.com/SoundScapeRenderer/homebrew-ssr/releases/download/asdf-1.0.0_1"
    sha256 cellar: :any,                 arm64_sonoma: "f04fea750a65c473054312e4edb922d44b860cbe02c2a79091d6cbf8287dace5"
    sha256 cellar: :any,                 ventura:      "6c65e3237bd9949a894c7868a79e7b87d83055edf26f50d4abe50479f282cc13"
    sha256 cellar: :any,                 monterey:     "991df26fd0d23d3173dc5539b3ed6eefd8b319b31f8866b011d93b6098ac17cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3c052266fcf3126bd3c243ac094ffd9f806205c0edf7ddcf5b27ee55ba25fbd0"
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
