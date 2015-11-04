module Fog
   module Storage
     class Akamai
       class File < Fog::Model

         identity :key, :aliases => 'name'

         attribute :directory
         attribute :name
         attribute :mtime
         attribute :md5
         attribute :size
         attribute :body

         def get(key)
           requires :directory

         end

         def save
           # requires all attributes and saves
         end

         def destroy
           requires :name
           # should destroy
         end

         def ready?
           true
         end
       end
     end
   end
end
