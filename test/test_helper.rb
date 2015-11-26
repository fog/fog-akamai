$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'fog/akamai'
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |rb| require(rb) }
