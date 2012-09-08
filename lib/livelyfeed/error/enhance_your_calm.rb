require 'livelyfeed/error/client_error'

module Livelyfeed
  class Error
    # Raised when Livelyfeed returns the HTTP status code 420
    class EnhanceYourCalm < Livelyfeed::Error::ClientError
      HTTP_STATUS_CODE = 420
    end
  end
end