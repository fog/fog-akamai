require 'test_helper'
require 'helpers/download_request_stub'
require 'helpers/dir_request_stub'
require 'helpers/stat_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class FilesTest < StorageTestBase
      include DownloadRequestStub
      include DirRequestStub
      include StatRequestStub

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
    end
  end
end
