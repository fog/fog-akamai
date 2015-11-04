module DownloadRequestStub
  def download_body
    File.read(File.expand_path('../../assets/test2.jpg', __FILE__))
  end

  def stub_download(path, status = 200)
    stub_request(:get, "https://example-nsu.akamai.net#{path}").to_return(body: download_body, status: status)
  end
end