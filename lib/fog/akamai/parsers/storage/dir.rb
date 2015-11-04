module Fog
  module Parsers
    module Storage
      module Akamai
        class Dir < Fog::Parsers::Base
          def reset
            @response = { :directory => '', :files => [] }
          end

          def start_element(name, attrs = [])
            case name
              when 'stat'
                @response[:directory] = attrs.first.value
              when 'file'
                @response[:files] << attrs_to_hash(attrs) if is_file?(attrs)
            end
          end

          private

            def is_file?(attrs)
              attrs.any? { |attr| attr.localname == 'type' && attr.value == 'file' }
            end

            def attrs_to_hash(attrs)
              attrs.inject({}) { |result, attr| result.merge(attr.localname => attr.value) }
            end

        end
      end
    end
  end
end