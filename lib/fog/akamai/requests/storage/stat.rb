require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        require 'fog/akamai/parsers/storage/dir'

        def stat(path)
          fail(ArgumentError, 'path needs to have a value') if path.empty?
          request(:stat,
                  path: format_path(path),
                  method: 'GET',
                  expects: 200,
                  parser: Fog::Parsers::Storage::Akamai::Dir.new)
        end
      end

      class Mock
        def stat(path)
          fail(ArgumentError, 'path needs to have a value') if path.empty?

          path = Pathname.new(format_path(path))
          key = path.split.first.to_s

          response = Excon::Response.new
          response.status = get_status(key, path.basename.to_s)
          response.body = get_body(key)

          response
        end

        private

        def get_status(key, basename)
          if data.key?(key) &&
             (data[key][:directories].any? { |dir| dir['name'] == basename } ||
               data[key][:files].any? { |file| file['name'] == basename })
            200
          else
            404
          end
        end

        def get_body(key)
          data[key] if data.key?(key)
        end
      end
    end
  end
end
