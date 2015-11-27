module DuRequestStub
  def du_body(path, files, bytes)
    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
      <du directory=\"#{path}\">
        <du-info files=\"#{files}\" bytes=\"#{bytes}\" />
      </du>"
  end

  def stub_du(path, files = '42', bytes = '43')
    stub_request(:get, "https://example-nsu.akamai.net#{path}").to_return(body: du_body(path, files, bytes))
  end
end
