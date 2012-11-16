require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 422
    class UnprocessableEntity < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 422
    end
  end
end