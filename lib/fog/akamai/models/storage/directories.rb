module Fog
  module Storage
    class Akamai
      class Directories < Fog::Collection
        model Fog::Storage::Akamai::Directory

        def get(key)
          data = service.dir(key).body

          directory = new(key: data[:directory].sub("/#{service.akamai_cp_code}", ''))
          directory.files.load(data[:files].map { |file| file.merge(directory: directory) })

          directory
        end
      end
    end
  end
end
