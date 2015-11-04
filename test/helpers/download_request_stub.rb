module DownloadRequestStub
  def body
    File.read(File.expand_path('../../assets/test2.jpg', __FILE__))
  end

  def stub_for_path(path, status = 200)
    stub_request(:get, "https://example-nsu.akamai.net#{path}").to_return(body: body, status: status)
  end
end