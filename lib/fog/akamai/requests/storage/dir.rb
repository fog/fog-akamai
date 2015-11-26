module Fog
  module Storage
    class Akamai
      class Real
        require 'fog/akamai/parsers/storage/dir'

        # Use this action to return the structure for a selected directory
        # @return [Excon::Response] response:
        #   * body [Hash]:
        #     * directory [String] - Path to directory
        #     * files [Array]:
        #       * type [String]
        #       * name [String]
        #       * mtime [String]
        #       * size [String]
        #       * md5 [String]
        #     * directories [Array]:
        #       * type [String]
        #       * name [String]
        #       * mtime [String]

        def dir(path = '')
          request(:dir,
                  path: format_path(path),
                  method: 'GET',
                  expects: 200,
                  parser: Fog::Parsers::Storage::Akamai::Dir.new)
        end
      end

      class Mock
        def dir(path = '')
          key = format_path(path)
          data.key?(key) ? Response.new(status: 200, body: data[key]) : fail(Excon::Errors::NotFound, '404 Not Found')
        end
      end
    end
  end
end
