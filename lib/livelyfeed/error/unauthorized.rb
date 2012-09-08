require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 401
    class Unauthorized < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end