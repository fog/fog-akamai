require 'test_helper'
require 'helpers/dir_request_stub'

module Fog
  module Storage
    module Akamai
      class DirTest < Minitest::Test
        include DirRequestStub

        def test_dir_calls_akamai_with_the_corret_host_and_path
          stub_dir = stub_dir('/42/path')
          Fog::Storage[:akamai].dir('/path')
          assert_requested stub_dir
        end
      end
    end
  end
end
