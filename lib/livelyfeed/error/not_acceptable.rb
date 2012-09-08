require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 406
    class NotAcceptable < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end