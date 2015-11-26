require 'test_helper'
require 'helpers/dir_request_stub'
require 'fog/akamai/requests/storage_test_base'

module Fog
  module Storage
    class DirTest < StorageTestBase
      include DirRequestStub

      def test_dir_calls_akamai_with_the_corret_host_and_path
        stub_dir = stub_dir('/42/path')
        storage.dir('/path')
        assert_requested stub_dir
      end
    end
  end
end
