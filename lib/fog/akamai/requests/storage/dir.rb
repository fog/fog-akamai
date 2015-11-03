module Fog
  module Storage
    class Akamai
      class Real
        def dir(path = nil)
          path ||= ''
          request(:dir, { :path => format_path(path), :method => 'GET' })
        end
      end

      class Mock
        def dir
          raise Fog::Mock.not_implemented
        end
      end
    end
  end
end