require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to rename a file or symbolic link.
        # @param source [String] the path to check
        # @param destination [String] the path to check
        # @return [Excon::Response] response

        def rename(source, destination)
          path_guard(source)
          path_guard(destination)

          request({ action: :rename, destination: CGI.escape(format_path(destination)) },
                  path: format_path(source),
                  method: 'POST',
                  expects: 200)
        end
      end

      class Mock
        def rename(source, destination)
          path_guard(source)
          path_guard(destination)

          source_pathname = Pathname.new(format_path(source))
          destination_pathname = Pathname.new(format_path(destination))

          if rename_file(source_pathname, destination_pathname)
            move_file(source_pathname, destination_pathname)
            Excon::Response.new(status: 200)
          else
            fail(Excon::Errors::NotFound, '404 Not Found')
          end
        end

        private

        def rename_file(source, destination)
          source_dir = data[source.split.first.to_s] || { files: [] }
          source_file = source_dir[:files].find { |file| file['name'] == source.basename.to_s }
          source_file['name'] = destination.basename.to_s if source_file
        end

        def move_file(source, destination)
          data[destination.to_s] = data[source.to_s]
          data[source.to_s] = nil
        end
      end
    end
  end
end
