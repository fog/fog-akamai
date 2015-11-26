module Fog
  module Storage
    class Akamai
      class Real
        def upload(path, body)
          fail ArgumentError('path is required') if path.empty?
          fail ArgumentError('body is required') if body.nil?
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
          fail ArgumentError('path is required') if path.empty?
          fail ArgumentError('body is required') if body.nil?
        end
      end
    end
  end
end
