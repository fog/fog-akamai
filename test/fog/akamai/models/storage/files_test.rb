require 'test_helper'
require 'helpers/download_request_stub'
require 'helpers/dir_request_stub'

class Fog::Storage::Akamai::FilesTest < Minitest::Test
  include DownloadRequestStub
  include DirRequestStub

  def setup
    @file = File.read(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
  end

  def test_get
    stub_download('/42/test2.jpg')
    assert_equal @file, Fog::Storage[:akamai].files.get('/test2.jpg').body
  end

  def test_get_with_directory
    stub_dir('/42/path')
    stub_download('/42/path/test2.jpg')
    assert_equal @file, Fog::Storage[:akamai].directories.get('/path').files.get('test2.jpg').body
  end
end