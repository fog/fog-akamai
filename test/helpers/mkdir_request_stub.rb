module MkdirRequestStub
  def stub_mkdir(path)
    stub_request(:put, "https://example-nsu.akamai.net#{path}")
  end
end
