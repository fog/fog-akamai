# frozen_string_literal: true

module DeleteRequestStub
  def stub_delete(path)
    stub_request(:put, "https://example-nsu.akamai.net#{path}")
  end
end
