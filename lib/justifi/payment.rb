# frozen_string_literal: true

module Justifi
  module Payment
    class << self
      def create(params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payments",
          method: :post,
          params: params,
          headers: headers)
      end

      def create_refund(amount:, payment_id:, reason: nil, description: nil)
        refund_params = {amount: amount, description: description, reason: reason}
        JustifiOperations.idempotently_request("/v1/payments/#{payment_id}/refunds",
          method: :post,
          params: refund_params,
          headers: {})
      end

      def list(params: {}, headers: {})
        JustifiOperations.execute_get_request("/v1/payments", params, headers)
      end

      def get(payment_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/payments/#{payment_id}",
          {},
          headers)
      end

      def update(payment_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payments/#{payment_id}",
          method: :patch,
          params: params,
          headers: {})
      end

      def capture(payment_id:, amount: nil, headers: {}, idempotency_key: nil)
        params = amount.nil? ? {} : {amount: amount}
        JustifiOperations.idempotently_request("/v1/payments/#{payment_id}/capture",
          method: :post,
          params: params,
          headers: {})
      end
    end
  end
end
