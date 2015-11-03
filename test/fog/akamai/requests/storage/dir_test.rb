require 'test_helper'

class Fog::Storage::Akamai::DirTest < Minitest::Test
  def test_dir_calls_akamai_with_the_corret_host_and_path
    body = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
              <stat directory=\"/42/path\">
                <file type=\"file\" name=\"test2.jpg\" mtime=\"1397589678\" size=\"3515\" md5=\"cf5b610fdc84e711e2b57f902d2da359\"/>
                <file type=\"dir\" name=\"livechannels\" mtime=\"1436280736\"/>
                <file type=\"dir\" name=\"actors\" mtime=\"1427481034\"/>
                <file type=\"dir\" name=\"coupons\" mtime=\"1385310071\"/>
                <file type=\"file\" name=\"playlist.xml\" mtime=\"1402323157\" size=\"874\" md5=\"749cf09bb454e1c17c5878d505141439\"/>
                <file type=\"dir\" name=\"images\" mtime=\"1301668905\"/>
                <file type=\"file\" name=\"Console-App-Descriptions.zip\" mtime=\"1428516112\" size=\"33084587\" md5=\"3bbc67ec4094825ad0648ddfa6574678\"/>
                <file type=\"file\" name=\"audio.mp3\" mtime=\"1411759637\" size=\"86263891\" md5=\"7bfc37b3a0400033f9074294bb5adb6a\"/>
                <file type=\"dir\" name=\"Inside Hollywood\" mtime=\"1331560820\"/>
                <file type=\"dir\" name=\"series\" mtime=\"1418233136\"/>
                <file type=\"dir\" name=\"25_Days_Of_Bond\" mtime=\"1322761568\"/>
                <file type=\"dir\" name=\"static\" mtime=\"1446573315\"/>
                <file type=\"dir\" name=\"test\" mtime=\"1354754026\"/>
                <file type=\"dir\" name=\"spirit_week\" mtime=\"1319214482\"/>
                <file type=\"dir\" name=\"oscars\" mtime=\"1328034319\"/>
              </stat>"
    stub_request(:get, 'https://example-nsu.akamai.net/42/path').to_return(body: body)
    assert_equal body, Fog::Storage[:akamai].dir('/path').data[:body]
  end
end