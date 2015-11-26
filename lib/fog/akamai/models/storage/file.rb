module Fog
  module Storage
    class Akamai
      class File < Fog::Model
        include Fog::Akamai::Shared

        identity :key, aliases: 'name'

        attribute :directory
        attribute :name
        attribute :mtime
        attribute :md5
        attribute :size
        attribute :body

        def get(_key)
          requires :directory
        end

        def save
          requires :body, :directory, :key
          service.upload(full_path(key, directory), body)
        end

        def destroy
          requires :directory, :key
        end

        def ready?
          true
        end
      end
    end
  end
end
