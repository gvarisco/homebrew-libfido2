class Libfido2 < Formula
  desc "Provides library functionality for FIDO U2F and FIDO 2.0"
  homepage "https://developers.yubico.com/libfido2/"
  url "https://github.com/Yubico/libfido2/archive/1.2.0.tar.gz"
  sha256 "db94b4970ac6f85881b8a8c38976e4f336a42c3d512d009aea6ffecc3ea474dd"
  depends_on "cmake" => :build
  depends_on "mandoc" => :build
  depends_on "libcbor"
  depends_on "openssl@1.1"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["openssl@1.1"].opt_lib}/pkgconfig"
    args = std_cmake_args - %w[-DCMAKE_BUILD_TYPE=None]
    args << "-DCMAKE_BUILD_TYPE=None"
    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "man_symlink_html"
      system "make", "install"
    end
  end

  # Needs more comprehensive tests
  test do
    system "#{bin}/fido2-token", "-V"
  end
end
