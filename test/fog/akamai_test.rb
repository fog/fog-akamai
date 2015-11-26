require 'test_helper'

module Fog
  class AkamaiTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Fog::Akamai::VERSION
    end

    def test_that_it_loads_the_storage_module
      refute_nil Fog::Storage[:akamai]
    end

    def test_mock
      Fog.mock!
      storage = Fog::Storage::Akamai.new(
        akamai_host: 'example-nsu.akamai.net',
        akamai_key_name: 'key_name',
        akamai_key: 'key',
        akamai_cp_code: '42'
      )

      p storage.dir('/path')
    end
  end
end
