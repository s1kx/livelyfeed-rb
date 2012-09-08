require 'livelyfeed/error/server_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 503
    class ServiceUnavailable < Livelyfeed::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "LivelyFeed is over capacity."
    end
  end
end