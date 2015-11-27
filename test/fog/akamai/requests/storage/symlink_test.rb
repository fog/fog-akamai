require 'test_helper'
require 'helpers/symlink_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class SymlinkTest < StorageTestBase
      include SymlinkRequestStub

      def test_real
        symlink = stub_symlink('/42/path/sun.jpg', '/42/path/moon.jpg')
        storage.symlink('/path/sun.jpg', '/path/moon.jpg')

        assert_requested symlink
      end
    end
  end
end