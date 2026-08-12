class Buildchecker < Formula
  desc "Validates YouTrack tasks and comments on tasks and merge requests, for CI"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_build_checker.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-1.0.55-arm64-apple-darwin.tar.gz"
      sha256 "baadca028831938e0e36c917bd8e190f6b376237f7009f62f15c62e561f7e8ba"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/buildchecker/buildchecker-1.0.55-x86_64-apple-darwin.tar.gz"
      sha256 "e555b5bfa9d6872f773faf07f355a904a508261b5a977e7f338361b3e98b28d5"
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
    assert_match "1.0.55", shell_output("#{bin}/buildchecker --version")
    help = shell_output("#{bin}/buildchecker --help")
    assert_match "checkTask", help
    assert_match "addMRComment", help
    assert_match "addYoutrackComment", help
    assert_match "sendMattermostMessage", help
  end
end
