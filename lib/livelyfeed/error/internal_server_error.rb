require 'livelyfeed/error/internal_server_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 500
    class InternalServerError < Livelyfeed::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end