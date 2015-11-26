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
        def dir(_path = nil)
          response = Excon::Response.new
          response.headers['Status'] = 200

          response.body = {
          }

          response
        end
      end
    end
  end
end
