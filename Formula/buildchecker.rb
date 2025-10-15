class Buildchecker < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.29-arm64-apple-darwin.tar.gz"
      sha256 "accb9e1bd75a3cea14dc5af1ec6544be229712694937f78239f5aed11a00048e"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.29-x86_64-apple-darwin.tar.gz"
      sha256 "7f44abb333a6ccb730f1ee499fb3c1e35a98075949e4b2592d8c7362b260cfcf"
    end
  end

  def install
    bin.install "buildchecker"
  end

  test do
    # Test basic functionality
    (testpath/"test.yaml").write <<~EOS
      name: Test
      version: 1.0
      items:
        - first
        - second
    EOS

    # Test query
    output = shell_output("#{bin}/buildchecker #{testpath}/test.yaml -q name")
    assert_match "Test", output

    # Test version
    assert_match "v1.0.29", shell_output("#{bin}/buildchecker --version")
  end
end
