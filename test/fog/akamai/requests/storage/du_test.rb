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

    class MockDuTest < MockStorageTestBase
      def setup
        super

        storage.upload('/music/morning sun.wav', "Otis Redding Sittin' On")
        storage.mk_dir('/music/caravan')
        storage.mk_dir('/music/moondance')
      end

      def test_with_a_existing_dir_will_compute_a_body
        body = storage.du('/music').body

        assert_equal('/42/music', body[:directory])
        assert_equal('2', body[:bytes])
        assert_equal('1', body[:files])
      end

      def test_du_with_a_missing_dir_will_return_not_found
        assert_raises(Excon::Errors::NotFound) { storage.du('/bad_music') }
      end
    end
  end
end
