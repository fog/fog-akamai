$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'fog/akamai'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |rb| require(rb) }
