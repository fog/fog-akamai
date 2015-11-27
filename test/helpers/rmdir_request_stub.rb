module RmdirRequestStub
  def stub_rmdir(path)
    stub_request(:post, "https://example-nsu.akamai.net#{path}")
  end
end
