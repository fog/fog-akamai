require 'test_helper'
require 'helpers/download_request_stub'

class Fog::Storage::Akamai::DownloadTest < Minitest::Test
  include DownloadRequestStub

  def test_download_calls_akamai_with_the_correct_host_and_path
    stub_download = stub_download('/42/test2.jpg')
    Fog::Storage[:akamai].download('/test2.jpg')
    assert_requested stub_download
  end

  def test_download_will_raise_exception_if_status_is_not_ok
    stub_download('/42/test2.jpg', 404)
    assert_raises { Fog::Storage[:akamai].download('/test2.jpg') }
  end
end