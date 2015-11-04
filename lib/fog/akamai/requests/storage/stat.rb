module Fog
  module Storage
    class Akamai
      class Real
        require 'fog/akamai/parsers/storage/dir'

        def stat(path)
          raise ArgumentError.new('path needs to have a value') if path.empty?
          request(:stat, {
                         :path => format_path(path),
                         :method => 'GET',
                         :expects => 200,
                         :parser => Fog::Parsers::Storage::Akamai::Dir.new
                       })
        end
      end

      class Mock
        def stat(path)
          raise Fog::Mock.not_implemented
        end
      end
    end
  end
end