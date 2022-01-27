# frozen_string_literal: true

module Justifi
  module Payment
    module PaymentOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, params, headers)
        params = Util.normalize_params(params)
        super(path, params, headers)
      end
    end

    def self.success?(response)
      !response.nil? && response.http_status == 201
    end

    def self.create(params = {}, headers = {})
      response = PaymentOperations.execute_post_request("/v1/payments", params, headers)

      raise InvalidHttpResponseError.new(response: response) unless success?(response)

      response
    end
  end
end
