module Fog
  module Storage
    class Akamai
      class Real
        def download(path)
          request(:download,
                  {
                    :path => format_path(path),
                    :method => 'GET',
                    :expects => 200
                  })
        end
      end

      class Mock
      end
    end
  end
end