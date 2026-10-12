# frozen_string_literal: true

module UploadRequestStub
  def stub_upload(path)
    stub_request(:put, "https://example-nsu.akamai.net#{path}")
  end
end
