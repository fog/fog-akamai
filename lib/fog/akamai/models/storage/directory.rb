module Fog
  module Akamai
    class Storage
      class Directory < Fog::Model
        include Fog::Akamai::Shared

        identity :key, aliases: 'name'

        attribute :parent
        attribute :name
        attribute :mtime

        def files
          @files ||= Fog::Akamai::Storage::Files.new(
            directory: self,
            service: service
          )
        end

        def directories
          @directories ||= Fog::Akamai::Storage::Directories.new(
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
