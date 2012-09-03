module Livelyfeed
  # Custom error class for rescuing from all Livelyfeed errors
  class Error < StandardError
    attr_reader :wrapped_exception # , :rate_limit

    # @return [Hash]
    def self.errors
      @errors ||= Hash[descendants.map { |klass| [klass.const_get(:HTTP_STATUS_CODE), klass] }]
    end

    # @return [Array]
    def self.descendants
      ObjectSpace.each_object(::Class).select{|klass| klass < self}
    end

    # Initializes a new Error object
    #
    # @param exception [Exception, String]
    # @param response_headers [Hash]
    # @return [Livelyfeed::Error]
    def initialize(exception=$!, response_headers={})
      # @rate_limit = Livelyfeed::RateLimit.new(response_headers)
      if exception.respond_to?(:backtrace)
        super(exception.message)
        @wrapped_exception = exception
      else
        super(exception.to_s)
      end
    end

    def backtrace
      @wrapped_exception ? @wrapped_exception.backtrace : super
    end

  end
end