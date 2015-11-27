require 'test_helper'
require 'helpers/delete_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class DeleteTest < StorageTestBase
      include DeleteRequestStub

      def test_delete_calls_akamai_with_the_corret_host_and_path
        delete_request = stub_delete('/42/test/log lost friend.jpg')
        storage.delete('/test/log lost friend.jpg')
        assert_requested delete_request
      end
    end

    class MockDeleteTest < MockStorageTestBase
      def test_delete_when_file_was_uploaded_removes_data_entry
        storage.upload('/test/me and you.avi', '42')
        storage.delete('/test/me and you.avi')

        assert_nil storage.data['/42/test/me and you.avi']
        assert_empty storage.data['/42/test'][:files]
      end

      def test_delete_with_no_file_raise_exception
        assert_raises(Excon::Errors::NotFound) { storage.delete('/42/test/me and you.avi') }
      end
    end
  end
end
