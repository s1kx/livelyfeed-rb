require 'rack/utils'
require 'livelyfeed/http_methods'

module Livelyfeed
  module OAuth2
    class AccessToken
      include Livelyfeed::HttpMethods

      attr_reader :client, :token, :refresh_token, :expires_in, :expires_at, :params
      attr_accessor :options

      class << self
        # Initializes an AccessToken from a Hash
        #
        # @param [Client] the Livelyfeed::Client instance
        # @param [Hash] a hash of AccessToken property values
        # @return [AccessToken] the initalized AccessToken
        def from_hash(client, hash)
          self.new(client, hash.delete('access_token') || hash.delete(:access_token), hash)
        end

        # Initializes an AccessToken from a key/value application/x-www-form-urlencoded string
        #
        # @param [Client] client the Livelyfeed::Client instance
        # @param [String] kvform the application/x-www-form-urlencoded string
        # @return [AccessToken] the initalized AccessToken
        def from_kvform(client, kvform)
          from_hash(client, Rack::Utils.parse_query(kvform))
        end
      end

      # Initalize an AccessToken
      #
      # @param [Client] client the Livelyfeed::Client instance
      # @param [String] token the Access Token value
      # @param [Hash] options the options to create the Access Token with
      # @option options [String] :refresh_token (nil) the refresh_token value
      # @option options [FixNum, String] :expires_in (nil) the number of seconds in which the AccessToken will expire
      # @option options [FixNum, String] :expires_at (nil) the epoch time in seconds in which AccessToken will expire
      # @option options [Symbol] :mode (:header) the transmission mode of the Access Token parameter value
      #    one of :header, :body or :query
      # @option options [String] :header_format ('Bearer %s') the string format to use for the Authorization header
      # @option options [String] :param_name ('bearer_token') the parameter name to use for transmission of the
      #    Access Token value in :body or :query transmission mode
      def initialize(client, token, options = {})
        @client = client
        @token = token.to_s
        [:refresh_token, :expires_in, :expires_at].each do |arg|
          instance_variable_set("@#{arg}", options.delete(arg) || options.delete(arg.to_s))
        end
        @expires_in ||= options.delete('expires')
        @expires_in &&= @expires_in.to_i
        @expires_at ||= Time.now.to_i + @expires_in if @expires_in
        @options = {
          mode:           options.delete(:mode) || :header,
          header_format:  options.delete(:header_format) || 'Bearer %s',
          param_name:     options.delete(:param_name) || 'bearer_token'
        }
        @params = options
      end

      # Indexer to additional params present in token response
      #
      # @param [String] key entry key to Hash
      def [](key)
        @params[key]
      end

      # Whether or not the token expires
      #
      # @return [Boolean]
      def expires?
        !!@expires_at
      end

      # Whether or not the token is expired
      #
      # @return [Boolean]
      def expired?
        expires? && (expires_at < Time.now.to_i)
      end

      # Refreshes the current Access Token
      #
      # @return [AccessToken] a new AccessToken
      # @note options should be carried over to the new AccessToken
      def refresh!(params = {})
        raise "A refresh_token is not available" unless refresh_token
        params.merge!(@client.oauth_client_params).merge!(
          grant_type:     'refresh_token',
          refresh_token:  refresh_token
        )
        new_token = @client.get_token(params)
        new_token.options = options
        new_token
      end

      # Make a request with the Access Token
      #
      # @param [Symbol] verb the HTTP request method
      # @param [String] path the HTTP URL path of the request
      # @param [Hash] options the options to make the request with
      # @see Client#request
      def request(verb, path, options = {}, &block)
        set_token(options)
        @client.request(verb, path, options, &block)
      end

      # Get the headers hash (includes Authorization token)
      def headers
        { 'Authorization' => options[:header_format] % token }
      end

    private

      def set_token(opts)
        case options[:mode]
        when :header
          opts[:headers] ||= {}
          opts[:headers].merge!(headers)
        when :query
          opts[:params] ||= {}
          opts[:params][options[:param_name]] = token
        when :body
          opts[:body] ||= {}
          if opts[:body].is_a?(Hash)
            opts[:body][options[:param_name]] = token
          else
            opts[:body] << "&#{options[:param_name]}=#{token}"
          end
          # @todo support for multi-part (file uploads)
        else
          raise "invalid :mode option of #{options[:mode]}"
        end
      end
    end
  end
end