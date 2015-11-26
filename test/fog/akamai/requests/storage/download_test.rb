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
        assert_raises { storage.download('/test2.jpg') }
      end
    end
  end
end
