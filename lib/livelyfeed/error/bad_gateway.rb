require 'livelyfeed/error/server_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 502
    class BadGateway < Livelyfeed::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "LivelyFeed is down or being upgraded."
    end
  end
end