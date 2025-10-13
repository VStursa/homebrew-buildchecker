class Buildchecker < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.16-arm64-apple-darwin.tar.gz"
      sha256 "a442e86e671442044dc11b3b9d9f8f26545eb7574f5acb2ec4ce921ab1f37335"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.16-x86_64-apple-darwin.tar.gz"
      sha256 "cd6ec612bf389c1336f5354c75f8e06dc6d00be59030f08860b3abf65a5037e9"
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
    assert_match "v1.0.16", shell_output("#{bin}/buildchecker --version")
  end
end
