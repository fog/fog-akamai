module RenameRequestStub
  def stub_rename(source, _destination)
    stub_request(:post, "https://example-nsu.akamai.net#{source}")
  end
end
