require 'test_helper'

class Fog::Storage::Akamai::DirTest < Minitest::Test
  def test_something
    p Fog::Storage[:akamai].dir('webroot/webassets')
  end
end