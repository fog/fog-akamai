module Fog
  module Storage
    class Akamai
      class Directory < Fog::Model
        identity :key

        attribute :parent

        def files
          @files ||= Fog::Storage::Akamai::Files.new(
            directory: self,
            service: service
          )
        end

        def destroy
          requires :key
          service.rmdir(key)
        end
      end
    end
  end
end
