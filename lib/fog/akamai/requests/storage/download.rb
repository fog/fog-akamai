module Fog
  module Storage
    class Akamai
      class Real
        def download(path)
          path_guard(path)
          request(:download,
                  path: format_path(path),
                  method: 'GET',
                  expects: 200)
        end
      end

      class Mock
        def download(path)
          path_guard(path)
          fail(Excon::Errors::NotFound, '404 Not Found') unless data.key?(path) && data[path].key?(:body)
          Excon::Response.new(status: 200, body: data[path][:body])
        end
      end
    end
  end
end
