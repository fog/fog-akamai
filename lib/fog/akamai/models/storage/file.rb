module Fog
   module Storage
     class Akamai
       class File < Fog::Model

         attribute :name, :aliases => 'name'
         attribute :mtime, :aliases => 'mtime'
         attribute :md5, :aliases => 'md5'
         attribute :size, :aliases => 'size'
       end
     end
   end
end
