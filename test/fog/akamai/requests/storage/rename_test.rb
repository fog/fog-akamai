require 'test_helper'
require 'helpers/rename_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class RenameTest < StorageTestBase
      include RenameRequestStub

      def test_rename_calls_akamai_with_the_correct_host_and_path
        rename_request = stub_rename('/42/path/dangerous.txt', '/42/path/wisdom.txt')
        storage.rename('/path/dangerous.txt', '/path/wisdom.txt')
        assert_requested rename_request
      end
    end

    class MockRenameTest < MockStorageTestBase
      def test_rename_with_an_existing_file_renames_file
        storage.upload('/games/talos_principle.exe', 'explore')
        storage.rename('/games/talos_principle.exe', '/games/talos_painciple.exe')

        assert_equal('talos_painciple.exe', storage.data['/42/games'][:files].first['name'])
      end

      def test_rename_with_an_existing_file_moves_file
        storage.upload('/games/talos_principle.exe', 'explore')
        storage.rename('/games/talos_principle.exe', '/games/talos_painciple.exe')

        assert_equal('explore', storage.data['/42/games/talos_painciple.exe'][:body])
      end

      def test_rename_with_a_missing_file
        assert_raises(Excon::Errors::NotFound) { storage.rename('/games/missing', '/games/not_found') }
      end
    end
  end
end
