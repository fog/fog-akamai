require 'test_helper'
require 'helpers/du_request_stub'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class DuTest < StorageTestBase
      include DuRequestStub

      def test_du_calls_akamai_with_the_correct_host_and_path
        du_request = stub_du('/42/path')
        storage.du('/path')
        assert_requested du_request
      end

      def test_du_will_populate_the_body
        stub_du('/42/path', '42', '43')
        body = storage.du('/path').body
        assert_equal('/42/path', body[:directory])
        assert_equal('42', body[:files])
        assert_equal('43', body[:bytes])
      end
    end
  end
end