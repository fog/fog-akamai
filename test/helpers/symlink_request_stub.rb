# frozen_string_literal: true

module SymlinkRequestStub
  def stub_symlink(source, _target)
    stub_request(:post, "https://example-nsu.akamai.net#{source}")
  end
end
