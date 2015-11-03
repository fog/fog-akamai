$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'minitest/reporters'
require 'fog/akamai'

Excon.defaults.merge!(:debug_request => true, :debug_response => true)

MiniTest::Reporters.use!

Fog.credentials = {
  akamai_host: 'example-nsu.akamai.net',
  akamai_key_name: 'key_name',
  akamai_key: 'key',
  akamai_cp_code: '42'
}.merge(Fog.credentials)
