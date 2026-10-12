# frozen_string_literal: true

require 'test_helper'
require 'open3'
require 'rbconfig'
require 'stringio'

module Fog
  class AkamaiTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Fog::Akamai::VERSION
    end

    def test_that_it_loads_the_storage_module
      refute_nil Fog::Storage[:akamai]
    end

    def test_the_real_service_lives_in_the_provider_namespace
      assert_instance_of Fog::Akamai::Storage::Real, Fog::Storage[:akamai]
    end

    def test_the_mock_service_lives_in_the_provider_namespace
      Fog.mock!
      assert_instance_of Fog::Akamai::Storage::Mock, Fog::Storage[:akamai]
    ensure
      Fog.unmock!
    end

    def test_creating_the_service_does_not_log_a_deprecation
      log = StringIO.new
      original = Fog::Logger[:deprecation]
      Fog::Logger[:deprecation] = log

      Fog::Storage.new(provider: :akamai)

      assert_empty log.string
    ensure
      Fog::Logger[:deprecation] = original
    end

    def test_loading_the_provider_does_not_log_a_deprecation
      script = "require 'fog/akamai'; Fog::Storage.new(provider: :akamai, akamai_host: 'h', akamai_key_name: 'k', akamai_key: 's', akamai_cp_code: '1')"
      lib = File.expand_path('../../lib', __dir__)
      _out, err, status = Open3.capture3(RbConfig.ruby, "-I#{lib}", '-e', script)

      assert status.success?, err
      refute_match(/DEPRECATION/, err)
    end

    def test_the_pre_0_6_constant_still_resolves_to_the_same_class_and_is_deprecated
      deprecated = Warning[:deprecated]
      Warning[:deprecated] = true

      klass = nil
      assert_output(nil, /Fog::Storage::Akamai is deprecated/) { klass = Fog::Storage::Akamai }
      assert_same Fog::Akamai::Storage, klass
    ensure
      Warning[:deprecated] = deprecated
    end
  end
end
