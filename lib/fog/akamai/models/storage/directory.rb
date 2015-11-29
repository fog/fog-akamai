module Fog
  module Storage
    class Akamai
      class Directory < Fog::Model
        include Fog::Akamai::Shared

        identity :key, aliases: 'name'

        attribute :parent
        attribute :name
        attribute :mtime

        def files
          @files ||= Fog::Storage::Akamai::Files.new(
            directory: self,
            service: service
          )
        end

        def directories
          @directories ||= Fog::Storage::Akamai::Directories.new(
            parent: self,
            service: service
          )
        end

        def save
          requires :key
          path = parent.nil? ? key : full_path(key, parent)
          service.mkdir(path)
        end

        def destroy
          requires :key
          service.rmdir(key)
        end
      end
    end
  end
end
