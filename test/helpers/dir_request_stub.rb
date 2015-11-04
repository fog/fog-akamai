module DirRequestStub
  def dir_body
    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
      <stat directory=\"/42/path\">
        <file type=\"file\" name=\"test2.jpg\" mtime=\"1397589678\" size=\"3515\" md5=\"cf5b610fdc84e711e2b57f902d2da359\"/>
        <file type=\"dir\" name=\"livechannels\" mtime=\"1436280736\"/>
        <file type=\"dir\" name=\"actors\" mtime=\"1427481034\"/>
        <file type=\"dir\" name=\"coupons\" mtime=\"1385310071\"/>
        <file type=\"file\" name=\"playlist.xml\" mtime=\"1402323157\" size=\"874\" md5=\"749cf09bb454e1c17c5878d505141439\"/>
      </stat>"
  end

  def stub_dir(path)
    stub_request(:get, "https://example-nsu.akamai.net#{path}").to_return(body: dir_body)
  end
end