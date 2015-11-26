require 'pathname'

module Fog
  module Storage
    class Akamai
      class Real
        def mk_dir(path)
          fail(ArgumentError, "path is require, can't make a dir with no path") if path.nil? || path.empty?
          request(:mkdir,
                  path: format_path(path),
                  method: 'PUT',
                  expects: 200
                 )
        end
      end

      class Mock
        def mk_dir(path)
          fail(ArgumentError, "path is require, can't make a dir with no path") if path.nil? || path.empty?

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
