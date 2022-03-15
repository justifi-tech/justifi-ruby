# frozen_string_literal: true

module Justifi
  module PaymentMethod
    class << self
      def create(params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_methods",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def list(params: {}, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_methods", params, headers)
      end
    end
  end
end
