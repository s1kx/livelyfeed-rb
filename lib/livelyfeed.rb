require 'livelyfeed/configurable'
require 'livelyfeed/client'

module Livelyfeed
  class << self
    include Livelyfeed::Configurable

    # Delegate to a Livelyfeed::Client
    #
    # @return [Livelyfeed::Client]
    def client
      if @client && @client.cache_key == options.hash
        @client
      else
        @client = Livelyfeed::Client.new(options)
      end
    end

    def respond_to_missing?(method_name, include_private = false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private = false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Livelyfeed.setup