require 'test_helper'

class Fog::Akamai::StorageTest < Minitest::Test
  def setup
    @storage = Fog::Storage::Akamai.new(
      akamai_host: 'example-nsu.akamai.net',
      akamai_key_name: 'key_name',
      akamai_key: 'key',
      akamai_cp_code: '42'
    )
  end

  def test_that_if_all_require_params_it_will_init
    assert_instance_of Fog::Storage::Akamai::Real, @storage
  end

  def test_format_path_will_prefix_with_the_cp_code
    assert_equal '/42/path', @storage.format_path('path')
  end

  def test_format_path_work_for_empty_values
    assert_equal '/42', @storage.format_path('')
  end

  def test_acs_auth_data_has_the_correct_format
    Time.stub :now, Time.at(1446562868) do
      SecureRandom.stub :uuid, 'random-unique-uid-hopefully' do
        assert_equal '5, 0.0.0.0, 0.0.0.0, 1446562868, random-unique-uid-hopefully, key_name', @storage.acs_auth_data
      end
    end
  end

  def test_acs_action_has_the_correct_format
    assert_equal 'version=1&action=dir&format=xml', @storage.acs_action(:dir)
  end

  def test_acs_action_validates_actions
    assert_raises { @storage.acs_action(:gone_missing) }
  end

  def test_acs_auth_sign_will_return_the_base64_hmac_sha256
    assert_equal 'IW0ciCVRKh5w1hqtGJOXapfG1ddBTtcFd3ww+1nuG3E=', @storage.acs_auth_sign('data', 'path', :dir)
  end
end