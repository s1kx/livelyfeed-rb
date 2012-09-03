require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 404
    class NotFound < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end