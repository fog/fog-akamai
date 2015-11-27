require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to upload a file
        # @param path [String] the path to where to upload
        # @param body [File] the file to upload, can be file or a byte array
        # @return [Excon::Response] response

        def upload(path, body)
          path_and_body_guard(path, body)

          data = Fog::Storage.parse_data(body)
          request(:upload,
                  path: format_path(path),
                  method: 'PUT',
                  headers: data[:headers],
                  body: data[:body],
                  expects: 200)
        end
      end

      class Mock
        def upload(path, body)
          path_and_body_guard(path, body)

          path = Pathname(path)
          dir = path.split.first.to_s

          mkdir(dir)
          add_file(dir, path, body)

          Excon::Response.new(status: 200)
        end

        private

        def add_file(dir, path, body)
          data[format_path(dir)][:files] << build_file(body, path)
          data[format_path(path.to_s)] = { body: body }
        end

        def build_file(body, path)
          { 'type' => 'file', 'name' => path.basename.to_s, 'mtime' => DateTime.now.to_time.to_i.to_s, 'size' => body.size.to_s }
        end
      end
    end
  end
end
