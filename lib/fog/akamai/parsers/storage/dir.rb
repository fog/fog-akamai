module Fog
  module Parsers
    module Storage
      module Akamai
        class Dir < Fog::Parsers::Base
          def reset
            @response = { }
          end

          def start_element(name, attrs = [])
            case name
              when 'stat'
                @response[:directory] = attrs.first.value
            end
          end
        end
      end
    end
  end
end