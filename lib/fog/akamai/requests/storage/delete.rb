require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to delete an individual file or symbolic link.
        # @param path [String] the path for the file that will be downloaded
        # @return [Excon::Response] response

        def delete(path)
          path_guard(path)
          request(:delete,
                  path: format_path(path),
                  method: 'PUT',
                  expects: 200)
        end
      end

      class Mock
        def delete(path)
          path_guard(path)

          if remove_file(Pathname.new(format_path(path)))
            Excon::Response.new(status: 200)
          else
            fail(Excon::Errors::NotFound, '404 Not Found')
          end
        end

        private

        def remove_file(path)
          return false unless data.key?(path.to_s)

          data[path.to_s] = nil
          remove_file_from_parent_dir(path)
        end

        def remove_file_from_parent_dir(path)
          data[path.split.first.to_s][:files].reject! { |hash| hash['name'] == path.basename.to_s }
        end
      end
    end
  end
end
