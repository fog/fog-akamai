module StatRequestStub
  def stat_body_dir
    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
      <stat directory=\"/42/path\">
      </stat>"
  end

  def stat_body_file
    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
      <stat directory=\"/42/path\">
        <file type=\"file\" name=\"test2.jpg\" mtime=\"1397589678\" size=\"3515\" md5=\"cf5b610fdc84e711e2b57f902d2da359\"/>
      </stat>"
  end

  def stub_stat(path, status = 200)
     body = path.match(/\....$/) ? stat_body_file : stat_body_dir
    stub_request(:get, "https://example-nsu.akamai.net#{path}").to_return(body: body, status: status)
  end
end