require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 400
    class BadRequest < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end