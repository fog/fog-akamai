require 'test_helper'
require 'helpers/dir_request_stub'
require 'helpers/upload_request_stub'

module Fog
  module Storage
    module Akamai
      class FileTest < Minitest::Test
        include DirRequestStub
        include UploadRequestStub

        def test_save
          stub_dir('/42/path')
          stub_upload = stub_upload('/42/path/test2.jpg')

          body = File.open(File.expand_path('../../../../.../../../assets/test2.jpg', __FILE__))
          directory = Fog::Storage[:akamai].directories.get('/path')
          directory.files.create(
            key: 'test2.jpg',
            directory: directory,
            body: body
          )

          assert_requested stub_upload
        end
      end
    end
  end
end
