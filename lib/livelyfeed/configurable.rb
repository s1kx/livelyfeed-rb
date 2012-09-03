require 'livelyfeed/default'

module Livelyfeed
  module Configurable
    attr_writer :consumer_key, :consumer_secret
    attr_accessor :endpoint, :connection_options, :middleware, :oauth_authorize_path, :oauth_token_path

    class << self

      def keys
        @keys ||= [
          :consumer_key,
          :consumer_secret,
          :oauth_authorize_path,
          :oauth_token_path,
          :endpoint,
          :connection_options,
          :middleware,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    # @return [Fixnum]
    def cache_key
      options.hash
    end

    def reset!
      Livelyfeed::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Livelyfeed::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def credentials
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret
      }
    end

    # @return [Hash]
    def options
      Hash[Livelyfeed::Configurable.keys.map{ |key| [key, instance_variable_get(:"@#{key}")] }]
    end

  end
end