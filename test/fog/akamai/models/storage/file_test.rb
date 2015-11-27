require 'test_helper'
require 'helpers/dir_request_stub'
require 'helpers/upload_request_stub'
require 'helpers/mtime_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class FileTest < StorageTestBase
      include DirRequestStub
      include UploadRequestStub
      include MtimeRequestStub

      def test_save
        stub_dir('/42/path')
        stub_upload = stub_upload('/42/path/test2.jpg')

        body = File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
        directory = storage.directories.get('/path')
        directory.files.create(
          key: 'test2.jpg',
          directory: directory,
          body: body
        )

        assert_requested stub_upload
      end

      def test_touch_will_call_mtime_with_the_correct_path
        stub_dir('/42/path')
        mtime = stub_mtime('/42/path/test2.jpg')

        directory = storage.directories.get('/path')
        directory.files.first.touch

        assert_requested mtime
      end
    end
  end
end
