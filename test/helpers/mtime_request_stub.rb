# frozen_string_literal: true

module MtimeRequestStub
  def stub_mtime(path)
    stub_request(:post, "https://example-nsu.akamai.net#{path}")
  end
end
