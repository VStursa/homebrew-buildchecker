class Buildchecker < Formula
  desc "Validates YouTrack tasks and comments on tasks and merge requests, for CI"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-1.0.48-arm64-apple-darwin.tar.gz"
      sha256 "0bc1db5b2dfcc4e4369da4b25642181eb50c3194a04c332d5e48d9675e0b39c2"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-1.0.48-x86_64-apple-darwin.tar.gz"
      sha256 "aaab6551372583507ab5d76fce3fbac5849b3029d0cba626bccf936a707b7166"
    end
  end

  def install
    bin.install "buildchecker"
  end

  test do
    # The tool needs ~/.buildchecker/v1/ to do anything useful, so the smoke test is
    # limited to what runs without a configured environment. The four CI actions are
    # asserted by name: this formula is the last gate before the tap, and an upload
    # that quietly dropped one should fail here rather than in someone's pipeline.
    # The in-repo equivalent, which also checks their flags, is
    # tool/Tests/CLITests/FrozenSurfaceTests.swift.
    assert_match "1.0.48", shell_output("#{bin}/buildchecker --version")
    help = shell_output("#{bin}/buildchecker --help")
    assert_match "checkTask", help
    assert_match "addMRComment", help
    assert_match "addYoutrackComment", help
    assert_match "sendMattermostMessage", help
  end
end
