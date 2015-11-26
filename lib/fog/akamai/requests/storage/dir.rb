module Fog
  module Storage
    class Akamai
      class Real
        require 'fog/akamai/parsers/storage/dir'

        def dir(path = nil)
          path ||= ''
          request(:dir,
                  path: format_path(path),
                  method: 'GET',
                  expects: 200,
                  parser: Fog::Parsers::Storage::Akamai::Dir.new)
        end
      end

      class Mock
        def dir
          fail Fog::Mock.not_implemented
        end
      end
    end
  end
end
