require 'test_helper'
require 'helpers/mkdir_request_stub'
require 'timecop'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class MkDirTest < StorageTestBase
      include MkdirRequestStub

      def test_mk_dir_without_path_will_fail
        assert_raises(ArgumentError) { storage.mkdir(nil) }
        assert_raises(ArgumentError) { storage.mkdir('') }
      end

      def test_mk_dir_calls_correct_host_and_path
        stub_mk_dir = stub_mkdir('/42/test')
        storage.mkdir('/test')
        assert_requested stub_mk_dir
      end
    end

    class MockMkDirTest < MockStorageTestBase
      def test_mock_without_path_will_fail
        assert_raises(ArgumentError) { storage.mkdir(nil) }
        assert_raises(ArgumentError) { storage.mkdir('') }
      end

      def test_mock_with_path_will_create_dir
        storage.mkdir('/test')
        assert_equal({ directory: '/42/test', files: [], directories: [] }, storage.data['/42/test'])
      end

      def test_mock_with_composed_path_will_create_dir
        Timecop.freeze(Time.at(42)) do
          storage.mkdir('/test/composed')
        end

        assert_equal({ directory: '/42/test', files: [], directories: [{ 'type' => 'dir', 'name' => 'composed', 'mtime' => '42' }] }, storage.data['/42/test'])
        assert_equal({ directory: '/42/test/composed', files: [], directories: [] }, storage.data['/42/test/composed'])
      end

      def test_mock_will_add_directories
        Timecop.freeze(Time.at(42)) do
          storage.mkdir('/test/stop')
          storage.mkdir('/test/whatsthatsound')
        end

        child = { 'type' => 'dir', 'name' => 'whatsthatsound', 'mtime' => '42' }
        other_child = { 'type' => 'dir', 'name' => 'stop', 'mtime' => '42' }
        assert_equal({ directory: '/42/test', files: [], directories: [other_child, child] }, storage.data['/42/test'])
      end
    end
  end
end
