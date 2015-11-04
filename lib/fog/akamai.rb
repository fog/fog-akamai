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

    module Shared
      def full_path(path, directory = nil)
        if directory
          path = [directory.key, path].join('/')
        end
        path
      end
    end
  end
end
