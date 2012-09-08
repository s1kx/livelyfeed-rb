require 'livelyfeed/error/server_error'

module Livelyfeed
  class Error
    # Raised when LivelyFeed returns the HTTP status code 504
    class GatewayTimeout < Livelyfeed::Error::ServerError
      HTTP_STATUS_CODE = 504
      MESSAGE = "The LivelyFeed servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later."
    end
  end
end