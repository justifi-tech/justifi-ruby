# frozen_string_literal: true

module Justifi
  class Error < StandardError
    attr_reader :response_code, :http_error_detail

    def initialize(response_code, msg, http_error_detail: nil)
      super(msg)
      @response_code = response_code
      @http_error_detail = http_error_detail
    end
  end

  class InvalidHttpResponseError < Error
    def initialize(response:)
      super(
        response.http_status,
        response.error_message,
        http_error_detail: response.error_details,
      )
    end
  end
end
