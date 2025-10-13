class Buildchecker < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.23-arm64-apple-darwin.tar.gz"
      sha256 "3cc62ecd40cbd13c5bbf394ba839fc2882bfe57c62b63c661ec96464fcbd254f"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.23-x86_64-apple-darwin.tar.gz"
      sha256 "8fd2c855dfacbb8e9807cde0cd73a1fb7d6172ee3fcd6eee7629d7bd6fe31f3f"
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
    assert_match "v1.0.23", shell_output("#{bin}/buildchecker --version")
  end
end
