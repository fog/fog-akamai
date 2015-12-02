module Fog
  module Storage
    class Akamai
      class Files < Fog::Collection
        include Fog::Akamai::Shared

        model Fog::Storage::Akamai::File

        attribute :directory

        def all
          requires :directory
          directory.files
        end

        def get(path)
          body = service.download(full_path(path, directory)).data[:body]
          new(body: body)
        end

        def stat(path)
          new(service.stat(full_path(path, directory)).data[:body][:files].first)
        rescue Excon::Errors::NotFound
          nil
        end

        def new(attributes = {})
          requires :directory
          super({ :directory => directory }.merge!(attributes))
        end
      end
    end
  end
end
