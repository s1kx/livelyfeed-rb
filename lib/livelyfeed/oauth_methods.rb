require 'livelyfeed/oauth2/access_token'

module Livelyfeed
  module OAuthMethods
    # The OAuth client_id and client_secret
    #
    # @return [Hash]
    def oauth_client_params
      {
        'client_id'     => credentials[:consumer_key],
        'client_secret' => credentials[:consumer_secret]
      }
    end

    # Perform an HTTP request with OAuth2 error handlers
    #
    # @raise [Livelyfeed::Error::ClientError, Livelyfeed::Error::DecodeError]
    def oauth_request(method, path, params = {}, options = {})
      response = request(method, path, params, options)
    end

    # The token endpoint URL of the OAuth2 provider
    #
    # @param [Hash] params additional query parameters
    def token_url(params = nil)
      connection.build_url(oauth_token_path, params).to_s
    end

    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] options
    # @return [AccessToken] the initalized AccessToken
    def get_token(params, options = {})
      opts = {
        raise_errors:   options[:raise_errors],
        parse:          params.delete(:parse)
      }

      headers = params.delete(:headers)
      opts[:headers] = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      opts[:headers].merge!(headers) if headers
      opts[:ignore_access_token] = true

      response = oauth_request(:post, token_url, params, opts)

      raise Error.new(response) if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])

      Livelyfeed::OAuth2::AccessToken.from_hash(self, response[:body])
    end

    # Initializes an AccessToken by making a request to the given assertion url
    #
    # @param [String] url
    # @param [Hash] params a Hash of params for the token endpoint
    # @return [AccessToken] the initalized AccessToken
    def get_token_from_assertion(url, params)
      opts = {
        raise_errors:   options[:raise_errors],
        parse:          params.delete(:parse)
      }

      headers = params.delete(:headers)
      opts[:headers] = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      opts[:headers].merge!(headers) if headers
      opts[:ignore_access_token] = true

      response = oauth_request(:post, url, params, opts)

      raise Error.new(response) if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])

      Livelyfeed::OAuth2::AccessToken.from_hash(self, response[:body])
    end

    # Retrieve an access token for the current application
    #
    # @param [Hash] params additional params
    def sign_in_as_client(params = {}, options = {})
      params = {
        'grant_type' => 'client_credentials'
      }.merge(oauth_client_params).merge(params)

      @access_token = get_token(params, options)
    end

    # Retrieve an access token given the specified End User username and password.
    #
    # @param [String] username the End User username
    # @param [String] password the End User password
    # @param [Hash] params additional params
    def sign_in_with_credentials(username, password, params = {}, options = {})
      params = {
        'grant_type' => 'password',
        'username'   => username,
        'password'   => password
      }.merge(oauth_client_params).merge(params)

      @access_token = get_token(params, options)
    end

    # Retrieve an access token given the specified Facebook OAuth token.
    #
    # @param [String] oauth_token
    # @param [Hash] params additional params
    def sign_in_with_facebook(oauth_token, params = {}, options = {})
      params = {
        'oauth_token' => oauth_token
      }.merge(oauth_client_params).merge(params)

      url = connection.build_url("/auth/facebook").to_s

      @access_token = get_token_from_assertion(url, params)
    end

    # Retrieve an access token given the specified Twitter OAuth token & secret.
    #
    # @param [String] oauth_token
    # @param [String] oauth_token_secret
    # @param [Hash] params additional params
    def sign_in_with_twitter(oauth_token, oauth_token_secret, params = {}, options = {})
      params = {
        'oauth_token' => oauth_token,
        'oauth_token_secret' => oauth_token_secret
      }.merge(oauth_client_params).merge(params)

      url = connection.build_url("/auth/twitter").to_s

      @access_token = get_token_from_assertion(url, params)
    end
  end
end