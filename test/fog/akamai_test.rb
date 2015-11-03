require 'test_helper'

class Fog::AkamaiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Fog::Akamai::VERSION
  end
end
