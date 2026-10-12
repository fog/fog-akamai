# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  skip '/test/'
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest/autorun'
require 'minitest/mock'
require 'fog/akamai'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |rb| require(rb) }
