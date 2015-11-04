require 'test_helper'
require 'helpers/dir_request_stub'

class Fog::Storage::Akamai::DirTest < Minitest::Test
  include DirRequestStub

  def test_dir_calls_akamai_with_the_corret_host_and_path
    stub_for_path('/42/path')
    assert_equal 200, Fog::Storage[:akamai].dir('/path').data[:status]
  end
end