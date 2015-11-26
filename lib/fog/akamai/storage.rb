module Fog
  module Storage
    class Akamai < Fog::Service
      requires :akamai_host, :akamai_key_name, :akamai_key, :akamai_cp_code

      VALID_ACTIONS = [:dir, :mkdir, :download, :stat, :upload, :delete]
      ACS_AUTH_DATA_HEADER = 'X-Akamai-ACS-Auth-Data'
      ACS_AUTH_SIGN_HEADER = 'X-Akamai-ACS-Auth-Sign'
      ACS_AUTH_ACTION_HEADER = 'X-Akamai-ACS-Action'

      model_path 'fog/akamai/models/storage'
      collection :directories
      model :directory
      collection :files
      model :file

      request_path 'fog/akamai/requests/storage'
      request :dir
      request :mk_dir
      request :download
      request :stat
      request :upload
      request :delete

      module Helpers
        def format_path(path)
          ["/#{akamai_cp_code}", path].reject(&:empty?).join
        end

        def path_and_body_guard(path, body)
          path_guard(path)
          fail ArgumentError('body is required') if body.nil?
        end

        def path_guard(path)
          fail(ArgumentError, 'path needs to have a value') if path.nil? || path.empty?
        end
      end

      module Initializer
        def self.included(klass)
          klass.instance_eval do
            attr_reader :akamai_key, :akamai_host, :akamai_cp_code, :akamai_key_name, :scheme, :port
          end
        end

        def init(options)
          @akamai_host = options[:akamai_host]
          @akamai_key_name = options[:akamai_key_name]
          @akamai_key = options[:akamai_key]
          @akamai_cp_code = options[:akamai_cp_code]

          @scheme = options[:scheme] || 'https'
          @port = options[:port] || 443
        end
      end

      class Mock
        include Helpers
        include Initializer

        def self.data
          @data ||= {}
        end

        def initialize(options = {})
          init(options)
        end

        def data
          self.class.data
        end

        def reset_data
          self.class.data.clear
        end
      end

      class Real
        include Helpers
        include Initializer

        # Initialize connection to Akamai
        #
        # ==== Notes
        # options parameter must include values for :akamai_host, :akamai_key_name,
        # :akamai_key and :akamai_cp_code in order to create a connection
        #
        # ==== Examples
        #   akamai_storage = Storage.new(
        #     :akamai_host => your_akamai_host_name,
        #     :akamai_key_name => you_akamai_key_name,
        #     :akamai_key => you_akamai_key,
        #     :akamai_cp_code => your_cp_code
        #   )
        #
        # ==== Parameters
        # * options<~Hash> - config arguments for connection.  Defaults to {}.
        #
        # ==== Returns
        # * Storage object for akamai.
        def initialize(options = {})
          init(options)
        end

        def acs_auth_data
          version = '5'
          reserved_field1 = '0.0.0.0'
          reserved_field2 = '0.0.0.0'
          time = Time.now.to_i.to_s
          unique_id = SecureRandom.uuid
          [version, reserved_field1, reserved_field2, time, unique_id, akamai_key_name].join(', ')
        end

        def acs_action(action)
          fail(ArgumentError, "Invalid action #{action} valid actions are: #{VALID_ACTIONS}") unless VALID_ACTIONS.include?(action)

          "version=1&action=#{action}&format=xml"
        end

        def acs_auth_sign(auth_data, path, action)
          data = auth_data + sign_string(path, action)
          digest = OpenSSL::Digest::Digest::SHA256.new
          Base64.encode64(OpenSSL::HMAC.digest(digest, akamai_key, data)).strip
        end

        private

        def request(action, params)
          url = "#{scheme}://#{akamai_host}:#{port}"

          path = params[:path]
          auth_data = acs_auth_data

          headers = {
            ACS_AUTH_DATA_HEADER => auth_data,
            ACS_AUTH_SIGN_HEADER => acs_auth_sign(auth_data, path, action),
            ACS_AUTH_ACTION_HEADER => acs_action(action)
          }.merge(params[:headers] || {})

          params = params.merge(headers: headers)
          Fog::XML::Connection.new(url).request(params)
        end

        def sign_string(path, action)
          action = "x-akamai-acs-action:#{acs_action(action)}\n"
          "#{path}\n#{action}"
        end
      end
    end
  end
end
