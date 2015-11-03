module Fog
   module Storage
     class Akamai
       class File < Fog::Model

         identity :name, :aliases => 'name'

         attribute :type, :aliases => 'type'
         attribute :mtime, :aliases => 'mtime'
         attribute :md5, :aliases => 'md5'
         attribute :size, :aliases => 'size'

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
