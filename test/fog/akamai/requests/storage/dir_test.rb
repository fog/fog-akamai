require 'test_helper'
require 'helpers/dir_request_stub'

module Fog
  module Storage
    class DirTest < Minitest::Test
      include DirRequestStub

      def test_dir_calls_akamai_with_the_corret_host_and_path
        stub_dir = stub_dir('/42/path')
        Fog::Storage[:akamai].dir('/path')
        assert_requested stub_dir
      end

      def test_moq_dir_with_existing_directory
        p Fog::Storage[:akamai].data.merge('/webroot/webassets' => { directory: '/path', files: [], directories: [] })
        p Fog::Storage[:akamai].dir('/webroot/webassets')
      end
    end
  end
end
