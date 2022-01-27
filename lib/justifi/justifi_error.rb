# frozen_string_literal: true

module Justifi
  class Error < StandardError
    attr_reader :response_code

    def initialize(response_code, msg)
      super(msg)
      @response_code = response_code
    end
  end

  class InvalidHttpResponseError < Error
    def initialize(response:)
      super(response.http_status, response.error_message)
    end
  end
end
