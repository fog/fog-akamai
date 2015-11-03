module Fog
  module Storage
    class Akamai
      class Files < Fog::Collection
        model Fog::Storage::Akamai::File

        def all
          load(data)
        end

        def get(identity)
          raise ArgumentError(identity)
        end
      end
    end
  end
end