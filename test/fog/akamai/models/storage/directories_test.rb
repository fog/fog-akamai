require 'test_helper'
require 'helpers/dir_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class DirectoriesTest < StorageTestBase
      include DirRequestStub

      def setup
        super
        stub_dir('/42/path')
      end

      def test_get_will_return_a_directory_with_the_correct_key
        assert_equal '/path', storage.directories.get('/path').key
      end

      def test_get_will_load_files
        assert_equal 2, storage.directories.get('/path').files.count
      end

      def test_get_will_load_directories
        assert_equal 3, storage.directories.get('/path').directories.count
      end

      def test_get_will_set_the_directory
        directory = storage.directories.get('/path')
        assert_equal [directory, directory], directory.files.map(&:directory)
      end
    end
  end
end
