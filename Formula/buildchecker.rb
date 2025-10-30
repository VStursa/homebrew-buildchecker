class Buildchecker < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.38-arm64-apple-darwin.tar.gz"
      sha256 "66ff28ece666514250f7d2e19149aaf1203e57262796297c7c34d00d193c9688"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-v1.0.38-x86_64-apple-darwin.tar.gz"
      sha256 "ff3d65d017d0aa930744942ac0b4791c3c61312b794a9e875268cab274929372"
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
    assert_match "v1.0.38", shell_output("#{bin}/buildchecker --version")
  end
end
