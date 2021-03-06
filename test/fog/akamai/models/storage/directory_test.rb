require 'test_helper'
require 'helpers/dir_request_stub'
require 'helpers/rmdir_request_stub'
require 'helpers/mkdir_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class DirectoryTest < StorageTestBase
      include DirRequestStub
      include RmdirRequestStub
      include MkdirRequestStub

      def test_destroy_will_call_rmdir_with_the_correct_path
        stub_dir('/42/path')
        rmdir = stub_rmdir('/42/path')

        directory = storage.directories.get('/path')
        directory.destroy

        assert_requested rmdir
      end

      def test_save_will_call_mkdir_with_the_correct_path
        stub_dir('/42/path')
        mkdir = stub_mkdir('/42/path/unborn')

        storage.directories.get('/path').directories.create(key: 'unborn')

        assert_requested mkdir
      end

      def test_save_with_no_parent_will_call_mkdir_with_the_correct_path
        mkdir = stub_mkdir('/42/path/unborn')

        storage.directories.create(key: '/path/unborn')

        assert_requested mkdir
      end
    end
  end
end
