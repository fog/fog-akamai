# frozen_string_literal: true

module Fog
  module Akamai
    class Storage
      class Directories < Fog::Collection
        model Fog::Akamai::Storage::Directory

        attribute :parent

        def all
          requires :parent
          parent.directories
        end

        def get(key)
          data = service.dir(key).body

          directory = new(key: data[:directory].sub("/#{service.akamai_cp_code}", ''))
          load_files(directory, data)
          load_directories(directory, data)

          directory
        end

        def new(attributes)
          super({ parent: parent }.merge!(attributes))
        end

        private

        def load_files(directory, data)
          directory.files.load(data[:files].map { |file| file.merge(directory: directory) })
        end

        def load_directories(directory, data)
          directory.directories.load(data[:directories].map { |dir| dir.merge(parent: directory) })
        end
      end
    end
  end
end
