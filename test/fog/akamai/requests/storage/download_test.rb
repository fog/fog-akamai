require 'test_helper'
require 'helpers/download_request_stub'
require 'fog/akamai/requests/storage_test_base'

module Fog
  module Storage
    class DownloadTest < StorageTestBase
      include DownloadRequestStub

      def test_download_calls_akamai_with_the_correct_host_and_path
        stub_download = stub_download('/42/test2.jpg')
        storage.download('/test2.jpg')
        assert_requested stub_download
      end

      def test_download_will_raise_exception_if_status_is_not_ok
        stub_download('/42/test2.jpg', 404)
        assert_raises(Excon::Errors::NotFound) { storage.download('/test2.jpg') }
      end
    end

    class MockDownloadTest < MockStorageTestBase
      attr_reader :body

      def setup
        super
        @body ||= File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
      end

      def test_with_a_uploaded_file
        storage.upload('/path/test.jpg', body)
        assert_equal(storage.download('/path/test.jpg').body, body)
      end

      def test_with_a_missing_file
        assert_raises(Excon::Errors::NotFound) { storage.download('/path/test.jpg') }
      end
    end
  end
end
