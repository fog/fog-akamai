require 'test_helper'

module Fog
  class AkamaiTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Fog::Akamai::VERSION
    end

    def test_that_it_loads_the_storage_module
      refute_nil Fog::Storage[:akamai]
    end
  end
end
