module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to download a file
        # @param path [String] the path for the file that will be downloaded
        # @return [Excon::Response] response:
        #   * body [binary]

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
          formatted_path = format_path(path)
          fail(Excon::Errors::NotFound, '404 Not Found') unless data.key?(formatted_path) && data[formatted_path].key?(:body)
          Excon::Response.new(status: 200, body: data[formatted_path][:body])
        end
      end
    end
  end
end
