require 'test_helper'
require 'helpers/upload_request_stub'

module Fog
  module Storage
    module Akamai
      class UploadTest < Minitest::Test
        include UploadRequestStub

        def setup
          @body = File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
        end

        def test_upload
          stub_upload = stub_upload('/42/path/test2.jpg')
          Fog::Storage[:akamai].upload('/path/test2.jpg', @body)
          assert_requested stub_upload
        end
      end
    end
  end
end
