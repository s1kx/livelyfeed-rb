require 'livelyfeed/error'

module Livelyfeed
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Livelyfeed::Error
    end
  end
end