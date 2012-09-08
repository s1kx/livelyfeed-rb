require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 429
    class RateLimited < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 429
    end
  end
end