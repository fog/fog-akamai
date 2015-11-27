require 'test_helper'
require 'helpers/dir_request_stub'
require 'fog/akamai/storage_test_base'

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

    class MockDirTest < MockStorageTestBase
      def test_when_a_dir_exists_will_return_the_dir
        storage.mk_dir('/test')
        assert_equal({ directory: '/42/test', files: [], directories: [] }, storage.dir('/test').body)
      end

      def test_when_dir_does_not_exist_will_raise_exception
        assert_raises(Excon::Errors::NotFound) { storage.dir('/test') }
      end
    end
  end
end
