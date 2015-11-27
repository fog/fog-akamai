require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to change a file's modification time ("touch").
        # @param path [String] the path for he file that will be downloaded
        # @param mtime [int] the desired modification time for the target content (i.e., in UNIX epoch time).
        # @return [Excon::Response] response

        def mtime(path, mtime = DateTime.now.to_time.to_i)
          path_guard(path)
          request({ action: :mtime, mtime: mtime },
                  path: format_path(path),
                  method: 'POST',
                  expects: 200)
        end
      end

      class Mock
        def mtime(path, mtime = DateTime.now.to_time.to_i)
          path_guard(path)

          pathname = Pathname.new(format_path(path))
          file = get_file(pathname)

          if file
            file['mtime'] = mtime.to_s
            Excon::Response.new(status: 200)
          else
            fail(Excon::Errors::NotFound, '404 Not Found')
          end
        end

        private

        def get_file(pathname)
          dir = data[pathname.split.first.to_s] || { files: [] }
          dir[:files].find { |file_hash| file_hash['name'] == pathname.basename.to_s }
        end
      end
    end
  end
end
