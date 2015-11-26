module MkDirRequestStub
  def stub_mk_dir(path)
    stub_request(:put, "https://example-nsu.akamai.net#{path}")
  end
end
