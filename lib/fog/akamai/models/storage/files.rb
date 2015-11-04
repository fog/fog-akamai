module Fog
  module Storage
    class Akamai
      class Files < Fog::Collection
        model Fog::Storage::Akamai::File

        attribute :directory

        def all
          requires :directory
        end

        def get(identity)
          raise ArgumentError(identity)
        end
      end
    end
  end
end