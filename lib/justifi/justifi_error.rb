# frozen_string_literal: true

module Justifi
  class Error < StandardError
    attr_reader :response_code, :error_details

    def initialize(response_code, msg, error_details: nil)
      super(msg)
      @response_code = response_code
      @error_details = error_details
    end
  end

  class InvalidHttpResponseError < Error
    def initialize(response:)
      super(response.http_status, response.error_message, error_details: response.error_details)
    end
  end
end
