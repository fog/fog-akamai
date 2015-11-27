module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to rename a file or symbolic link.
        # @param source [String] the path to check
        # @param target [String] the path to check
        # @return [Excon::Response] response

        def symlink(source, target)
          path_guard(source)
          path_guard(target)

          request({ action: :symlink, target: CGI.escape(format_path(target)) },
                  path: format_path(source),
                  method: 'POST',
                  expects: 200)
        end
      end

      class Mock
      end
    end
  end
end
