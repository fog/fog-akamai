require 'test_helper'
require 'helpers/download_request_stub'

class Fog::Storage::Akamai::FilesTest < Minitest::Test
  include DownloadRequestStub

  def test_get
    stub_for_path('/42/test2.jpg')
    file = File.read(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
    assert_equal file, Fog::Storage[:akamai].files.get('/test2.jpg').body
  end
end