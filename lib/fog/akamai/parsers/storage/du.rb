module Fog
  module Parsers
    module Storage
      module Akamai
        class Du < Fog::Parsers::Base
          def reset
            @response = { directory: '', files: '', bytes: '' }
          end

          def start_element(name, attrs = [])
            case name
            when 'du'
              @response[:directory] = value_for_attr(attrs, 'directory')
            when 'du-info'
              @response[:files] = value_for_attr(attrs, 'files')
              @response[:bytes] = value_for_attr(attrs, 'bytes')
            end
          end

          private

          def value_for_attr(attrs, name)
            attrs.find { |attr| attr.localname == name }.value
          end
        end
      end
    end
  end
end
