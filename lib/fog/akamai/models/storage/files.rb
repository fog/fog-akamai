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
          body = service.download(full_path(path)).data[:body]
          new(:body => body)
        end

        def stat(path)
          new(service.stat(full_path(path)).data[:body][:files].first)
        rescue Excon::Errors::NotFound
          nil
        end

        private

          def full_path(path)
            if directory
              path = [directory.key, path].join('/')
            end
            path
          end
      end
    end
  end
end