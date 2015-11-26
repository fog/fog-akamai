module Fog
  module Parsers
    module Storage
      module Akamai
        class Dir < Fog::Parsers::Base
          def reset
            @response = { directory: '', files: [], directories: [] }
          end

          def start_element(name, attrs = [])
            case name
            when 'stat'
              @response[:directory] = attrs.first.value
            when 'file'
              @response[:files] << attrs_to_hash(attrs) if of_type?(attrs, 'file')
              @response[:directories] << attrs_to_hash(attrs) if of_type?(attrs, 'dir')
            end
          end

          private

          def of_type?(attrs, type)
            attrs.any? { |attr| attr.localname == 'type' && attr.value == type }
          end

          def attrs_to_hash(attrs)
            attrs.inject({}) { |a, e| a.merge(e.localname => e.value) }
          end
        end
      end
    end
  end
end
