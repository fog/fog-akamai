module Fog
  module Storage
    class Akamai
      class Directories < Fog::Collection
        model Fog::Storage::Akamai::Directory

        def get(key)
          data = service.dir(key).body
          new(:key => data[:directory].sub("/#{service.akamai_cp_code}", ''))
        end
      end
    end
  end
end