require 'faraday'
require 'livelyfeed/version'
require 'livelyfeed/configurable'
require 'livelyfeed/error/client_error'
require 'livelyfeed/response/parse_json'
require 'livelyfeed/response/raise_error'

module Livelyfeed
  module Default
    ENDPOINT = 'http://api.livelyfeed.com' unless defined? ENDPOINT
    OAUTH_AUTHORIZE_PATH = '/oauth/authorize' unless defined? OAUTH_AUTHORIZE_PATH
    OAUTH_TOKEN_PATH = '/oauth/token' unless defined? OAUTH_TOKEN_PATH
    CONNECTION_OPTIONS = {
      headers: {
        accept: 'application/json',
        user_agent: "Livelyfeed Ruby Gem #{Livelyfeed::Version}"
      },
      open_timeout: 5,
      raw: true,
      ssl: { verify: false },
      timeout: 10,
    } unless defined? CONNECTION_OPTIONS
    #IDENTITY_MAP = Livelyfeed::IdentityMap unless defined? IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new(
      &Proc.new do |builder|
        # Convert file uploads to Faraday::UploadIO objects
        #builder.use Livelyfeed::Request::MultipartWithFile
        # Checks for files in the payload
        builder.use Faraday::Request::Multipart
        # Convert request params to "www-form-urlencoded"
        builder.use Faraday::Request::UrlEncoded
        # Handle 4xx server responses
        builder.use Livelyfeed::Response::RaiseError, Livelyfeed::Error::ClientError
        # Parse JSON response bodies using MultiJson
        builder.use Livelyfeed::Response::ParseJson
        # Handle 5xx server responses
        #builder.use Livelyfeed::Response::RaiseError, Livelyfeed::Error::ServerError
        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end
    )

    class << self

      # @return [Hash]
      def options
        Hash[Livelyfeed::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # @return [String]
      def consumer_key
        ENV['LIVELYFEED_CONSUMER_KEY']
      end

      # @return [String]
      def consumer_secret
        ENV['LIVELYFEED_CONSUMER_SECRET']
      end

      # @note This is configurable in case you want to use HTTP instead of HTTPS or use a Twitter-compatible endpoint.
      # @return [String]
      def endpoint
        ENDPOINT
      end

      # @return [Hash]
      def connection_options
        CONNECTION_OPTIONS
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

      # @return [String]
      def oauth_authorize_path
        OAUTH_AUTHORIZE_PATH
      end

      # @return [String]
      def oauth_token_path
        OAUTH_TOKEN_PATH
      end

    end
  end
end