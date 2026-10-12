# frozen_string_literal: true

require 'fog/core'
require 'fog/xml'
require 'fog/akamai/version'

module Fog
  module Akamai
    extend Fog::Provider

    autoload :Storage, 'fog/akamai/storage'

    service(:storage, 'Storage')

    module Shared
      def full_path(path, directory = nil)
        path = [directory.key, path].join('/') if directory
        path
      end
    end
  end

  module Storage
    # Deprecated: use Fog::Akamai::Storage. The alias is defined in fog/akamai/storage.
    autoload :Akamai, 'fog/akamai/storage'
  end
end
