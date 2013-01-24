require 'faraday'
require 'livelyfeed/error/bad_gateway'
require 'livelyfeed/error/bad_request'
# require 'livelyfeed/error/unprocessable_entity'
require 'livelyfeed/error/enhance_your_calm'
require 'livelyfeed/error/forbidden'
require 'livelyfeed/error/internal_server_error'
require 'livelyfeed/error/gateway_timeout'
require 'livelyfeed/error/not_acceptable'
require 'livelyfeed/error/not_found'
require 'livelyfeed/error/service_unavailable'
require 'livelyfeed/error/unauthorized'
require 'livelyfeed/error/rate_limited'

module Livelyfeed
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end