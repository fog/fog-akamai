require 'test_helper'
require 'helpers/stat_request_stub'
require 'fog/akamai/requests/storage_test_base'

module Fog
  module Storage
    class StatTest < StorageTestBase
      include StatRequestStub

      def test_stat_for_file
        stub_stat('/42/path/test2.jpg')
        refute_empty storage.stat('/path/test2.jpg').data[:body][:files]
      end

      def test_stat_for_dir
        stub_stat('/42/path')
        refute_empty storage.stat('/path').data[:body][:directory]
      end

      def test_stat_missing
        stub_stat('/42/path/test3.jpg', 404)
        assert_raises { storage.stat('/path/test3.jpg') }
      end
    end

    class MockStatTest < MockStorageTestBase
      def test_for_an_existing_directory
        directory = { directory: '/42', files: [], directories: [{ 'type' => 'dir', 'name' => 'test', 'mtime' => '42' }] }
        storage.data['/42'] = directory
        assert_equal(directory, storage.stat('/test').body)
      end

      def test_for_non_existing_child_directory
        directory = { directory: '/42', files: [], directories: [] }
        storage.data['/42'] = directory

        assert_raises(Excon::Errors::NotFound) { storage.stat('/test') }
      end

      def test_for_non_existing_parent_directory
        assert_raises(Excon::Errors::NotFound) { storage.stat('/test') }
      end

      def test_for_an_existing_file
        directory = { directory: '/42/test', files: [{ 'type' => 'file', 'name' => 'tom petty.mp3', 'mtime' => '42', 'size' => '43' }], directories: [] }
        storage.data['/42/test'] = directory

        assert_equal(200, storage.stat('/test/tom petty.mp3').status)
      end
    end
  end
end
