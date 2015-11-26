require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        # Use this action to create a dir
        # @param path [String] the path to create, it will create directories recursively
        # @return [Excon::Response] response

        def mk_dir(path)
          path_guard(path)
          request(:mkdir,
                  path: format_path(path),
                  method: 'PUT',
                  expects: 200
                 )
        end
      end

      class Mock
        def mk_dir(path)
          path_guard(path)

          path = Pathname.new(format_path(path))
          last_path_basename = ''

          path.ascend do |parent|
            break if parent.nil?

            key = parent.to_s
            update_data(key, last_path_basename)
            last_path_basename = parent.basename.to_s
          end

          Excon::Response.new(headers: { 'Status' => 200 })
        end

        private

        def update_data(key, last_path_basename)
          data[key] ||= { directory: key, files: [], directories: [] }
          data[key][:directories] << build_directory_node(last_path_basename) unless last_path_basename.empty?
        end

        def build_directory_node(last_path_basename)
          { 'type' => 'dir', 'name' => last_path_basename, 'mtime' => DateTime.now.to_time.to_i.to_s }
        end
      end
    end
  end
end
