# frozen_string_literal: true

module Justifi
  class Error < StandardError
    attr_reader :response_code, :response

    def initialize(response_code, msg, response: nil)
      super(msg)
      @response_code = response_code
      @response = response
    end
  end

  class InvalidHttpResponseError < Error
    def initialize(response:)
      super(response.http_status, response.error_message, response: response)
    end
  end
end
