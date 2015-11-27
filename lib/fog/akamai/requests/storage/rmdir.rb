module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to delete an empty directory.
        # @param path [String] the path to the directory
        # @return [Excon::Response] response

        def rmdir(path)
          path_guard(path)
          request(:rmdir,
                  method: 'POST',
                  path: format_path(path),
                  expects: 200)
        end
      end

      class Mock
        def rmdir(path)
          path_guard(path)

          formatted_path = format_path(path)
          dir = data[formatted_path]

          if empty?(dir)
            data.delete(formatted_path)
            Excon::Response.new(status: 200)
          else
            fail(Excon::Errors::Conflict, 'Not a empty directory')
          end
        end

        private

        def empty?(dir)
          dir[:files].empty? && dir[:directories].empty?
        end
      end
    end
  end
end
