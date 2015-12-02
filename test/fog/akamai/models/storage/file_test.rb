require 'test_helper'
require 'helpers/dir_request_stub'
require 'helpers/upload_request_stub'
require 'helpers/mtime_request_stub'
require 'helpers/rename_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class FileTest < StorageTestBase
      include DirRequestStub
      include UploadRequestStub
      include MtimeRequestStub
      include RenameRequestStub

      def test_save
        stub_dir('/42/path')
        stub_upload = stub_upload('/42/path/test2.jpg')

        body = File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
        storage.directories.get('/path').files.create(
          key: 'test2.jpg',
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

      def test_rename_will_call_rename_with_the_correct_path
        stub_dir('/42/path')
        rename = stub_rename('/42/path/test2.jpg', '/42/path/tranzistor radio.jpg')

        directory = storage.directories.get('/path')
        file = directory.files.first
        file.rename('tranzistor radio.jpg')

        assert_requested rename
        assert_equal 'tranzistor radio.jpg', file.key
      end
    end
  end
end
