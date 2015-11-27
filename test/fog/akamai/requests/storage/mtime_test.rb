require 'test_helper'
require 'helpers/mtime_request_stub'
require 'timecop'
require 'fog/akamai/storage_test_base'

module Fog
  module Storage
    class MtimeTest < StorageTestBase
      include MtimeRequestStub

      def test_mtime_calls_akamai_with_the_correct_host_and_path
        mtime_request = stub_mtime('/42/path')
        storage.mtime('/path')
        assert_requested mtime_request
      end
    end

    class MockMtimeTest < MockStorageTestBase
      def test_mtime_will_update_time_for_a_existing_file
        storage.upload('/movie/creedence.avi', 'water revival')
        storage.mtime('/movie/creedence.avi', Time.at(42).to_i)

        assert_equal('42', storage.data['/42/movie'][:files].first['mtime'])
      end

      def test_mtime_with_no_file_will_raise_not_found
        assert_raises(Excon::Errors::NotFound) { storage.mtime('changes.jpg') }
      end
    end
  end
end
