require 'test_helper'
require 'helpers/upload_request_stub'
require 'timecop'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    module UploadTestHelper
      def body
        @body ||= File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
      end
    end

    class UploadTest < StorageTestBase
      include UploadRequestStub
      include UploadTestHelper

      def test_upload
        stub_upload = stub_upload('/42/path/test2.jpg')
        storage.upload('/path/test2.jpg', body)
        assert_requested stub_upload
      end
    end

    class MockUploadTest < MockStorageTestBase
      include UploadTestHelper

      def test_mock
        Timecop.freeze(Time.at(42)) do
          storage.upload('/path/rocket man.jpg', body)
        end
        file = { 'type' => 'file', 'name' => 'rocket man.jpg', 'mtime' => '42', 'size' => body.size.to_s }
        directory = { directory: '/42/path', files: [file], directories: [] }
        assert_equal(directory, storage.data['/42/path'])
      end
    end
  end
end
