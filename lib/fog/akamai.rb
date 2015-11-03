require 'fog/core'
require 'fog/xml'
require 'fog/akamai/version'

module Fog
  module Storage
    autoload :Akamai, 'fog/akamai/storage'
  end

  module Akamai
    extend Fog::Provider

    service(:storage, 'Storage')
  end
end
