require 'test_helper'

class Fog::Storage::Akamai::DirectoriesTest < Minitest::Test
  def test_something
    assert_equal '/webroot/webassets', Fog::Storage[:akamai].directories.get('/webroot/webassets').key
  end
end
