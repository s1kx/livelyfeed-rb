require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 403
    class Forbidden < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end