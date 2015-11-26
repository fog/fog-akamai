require 'test_helper'
require 'helpers/stat_request_stub'

class Fog::Storage::Akamai::StatTest < Minitest::Test
  include StatRequestStub

  def test_stat_for_file
    stub_stat('/42/path/test2.jpg')
    refute_empty Fog::Storage[:akamai].stat('/path/test2.jpg').data[:body][:files]
  end

  def test_stat_for_dir
    stub_stat('/42/path')
    refute_empty Fog::Storage[:akamai].stat('/path').data[:body][:directory]
  end

  def test_stat_missing
    stub_stat('/42/path/test3.jpg', 404)
    assert_raises { Fog::Storage[:akamai].stat('/path/test3.jpg') }
  end
end
