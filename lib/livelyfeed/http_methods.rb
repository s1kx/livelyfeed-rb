module Livelyfeed
  module HttpMethods
    # Perform an HTTP DELETE request
    def delete(path, params = {}, options = {}, &block)
      request(:delete, path, params, options, &block)
    end

    # Perform an HTTP GET request
    def get(path, params = {}, options = {}, &block)
      request(:get, path, params, options, &block)
    end

    # Perform an HTTP POST request
    def post(path, params = {}, options = {}, &block)
      request(:post, path, params, options, &block)
    end

    # Perform an HTTP UPDATE request
    def put(path, params = {}, options = {}, &block)
      request(:put, path, params, options, &block)
    end

    # Perform an HTTP PATCH request
    def patch(path, params = {}, options = {}, &block)
      request(:patch, path, params, options, &block)
    end
  end
end