require 'test_helper'
require 'helpers/rmdir_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class RmdirTest < StorageTestBase
      include RmdirRequestStub

      def test_rmdir_calls_akamai_with_the_correct_host_and_path
        rmdir = stub_rmdir('/42/path')
        storage.rmdir('/path')
        assert_requested rmdir
      end
    end

    class MockRmdirTest < MockStorageTestBase
      def test_rmdir_of_an_empty_dir
        storage.mkdir('/path')
        storage.rmdir('/path')
        assert_nil storage.data['/42/path']
      end

      def test_rmdir_with_a_not_empty_dir_will_raise_request_conflict_409
        storage.upload('/path/dream.mkv', 'clocks')
        assert_raises(Excon::Errors::Conflict) { storage.rmdir('/path') }
      end
    end
  end
end
