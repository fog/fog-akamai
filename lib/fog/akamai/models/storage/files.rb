module Fog
  module Storage
    class Akamai
      class Files < Fog::Collection
        model Fog::Storage::Akamai::File

        attribute :directory

        def all
          requires :directory
        end

        def get(path)
          if directory
            path = [directory.key, path].join('/')
          end

          body = service.download(path).data[:body]
          new(:body => body)
        end
      end
    end
  end
end