class Buildchecker < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.25-arm64-apple-darwin.tar.gz"
      sha256 "e60e520ef333a5db3ec77f4fd1ff5c2da2b2c11f685762379d98073ec2a31db6"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.25-x86_64-apple-darwin.tar.gz"
      sha256 "a9ae34573535254bab84c5da4c4ccb35b8bd21d1861d570cd68b8b2d4d632d2f"
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
    assert_match "v1.0.25", shell_output("#{bin}/buildchecker --version")
  end
end
