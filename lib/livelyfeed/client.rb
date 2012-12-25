require 'faraday'
require 'multi_json'
require 'uri'
require 'livelyfeed/api'
require 'livelyfeed/configurable'
require 'livelyfeed/http_methods'
require 'livelyfeed/oauth_methods'
require 'livelyfeed/error/client_error'
require 'livelyfeed/error/decode_error'

module Livelyfeed
  # Wrapper for the LivelyFeed REST API
  class Client
    include Livelyfeed::API
    include Livelyfeed::Configurable
    include Livelyfeed::HttpMethods
    include Livelyfeed::OAuthMethods

    attr_accessor :access_token
    attr_reader :rate_limit

    attr_accessor :on_token_refresh

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Livelyfeed::Client]
    def initialize(options = {})
      Livelyfeed::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Livelyfeed.instance_variable_get(:"@#{key}"))
      end
      # @rate_limit = Livelyfeed::RateLimit.new
    end

  private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(builder: @middleware))
    end

    # Perform an HTTP request
    #
    # @raise [Livelyfeed::Error::ClientError, Livelyfeed::Error::DecodeError]
    def request(method, path, params = {}, options = {})
      uri = options[:endpoint] || @endpoint
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      request_headers = 
        if options[:plain_params]
          {}
        else
          {
            'Content-Type' => 'application/json'
          }
        end
      if credentials?
        if access_token && !options[:ignore_access_token]
          if access_token.expired?
            @access_token = access_token.refresh!
            on_token_refresh and on_token_refresh.call(@access_token)
          end
          request_headers.merge!(access_token.headers)
        end
      end
      connection.url_prefix = options[:endpoint] || @endpoint
      response = connection.run_request(method.to_sym, path, nil, request_headers) do |request|
        unless params.empty?
          case request.method
          when :post, :put
            if options[:plain_params]
              request.body = params
            else
              request.body = MultiJson.dump(params)
            end
          else
            request.params.update(params)
          end
        end
        yield request if block_given?
      end.env
      # @rate_limit.update(response[:response_headers])
      response
    rescue Faraday::Error::ClientError
      raise Livelyfeed::Error::ClientError
    rescue MultiJson::DecodeError
      raise Livelyfeed::Error::DecodeError
    end

  end
end