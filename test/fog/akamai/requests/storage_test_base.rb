require 'test_helper'

module Fog
  module Storage
    class StorageTestBase < Minitest::Test
      attr_reader :storage

      def setup
        @storage = Fog::Storage[:akamai]
      end
    end
  end
end
