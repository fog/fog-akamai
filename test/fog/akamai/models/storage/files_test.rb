require 'test_helper'
require 'helpers/download_request_stub'
require 'helpers/dir_request_stub'
require 'helpers/stat_request_stub'
require 'fog/akamai/storage_test_base'
require 'helpers/upload_request_stub'

module Fog
  module Storage
    class FilesTest < StorageTestBase
      include DownloadRequestStub
      include DirRequestStub
      include StatRequestStub
      include UploadRequestStub

      attr_reader :file

      def setup
        super
        @file = File.read(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
      end

      def test_get
        stub_download('/42/test2.jpg')
        assert_equal file, storage.files.get('/test2.jpg').body
      end

      def test_get_with_directory
        stub_dir('/42/path')
        stub_download('/42/path/test2.jpg')
        assert_equal file, storage.directories.get('/path').files.get('test2.jpg').body
      end

      def test_stat_with_existing_file
        stub_stat('/42/path/test2.jpg')
        refute_nil storage.files.stat('/path/test2.jpg')
      end

      def test_stat_with_non_existing_file
        stub_stat('/42/path/test3.jpg', 404)
        assert_nil storage.files.stat('/path/test3.jpg')
      end

      def test_create_without_a_directory
        stub_upload = stub_upload('/42/path/test.txt')
        storage.files.create(key: '/path/test.txt', body: '42')
        assert_requested stub_upload
      end
    end
  end
end
