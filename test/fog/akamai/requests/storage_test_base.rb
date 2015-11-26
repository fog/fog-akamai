require 'test_helper'

module Fog
  module Storage
    class StorageTestBase < Minitest::Test
      attr_reader :storage

      def setup
        @storage = Fog::Storage[:akamai]
      end
    end

    class MockStorageTestBase < StorageTestBase
      def setup
        Fog.mock!
        super
      end

      def teardown
        storage.reset_data
        Fog.unmock!
      end
    end
  end
end
