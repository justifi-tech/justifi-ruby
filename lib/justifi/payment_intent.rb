# frozen_string_literal: true

module Justifi
  module PaymentIntent
    class << self
      def list(params: {}, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_intents", params, headers)
      end

      def list_payments(id:, params: {}, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_intents/#{id}/payments", params, headers)
      end

      def get(id:, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_intents/#{id}",
          {},
          headers)
      end

      def update(id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_intents/#{id}",
          method: :patch,
          params: params,
          headers: {})
      end

      def create(params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_intents",
          method: :post,
          params: params,
          headers: headers)
      end

      def capture(id:, params:, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_intents/#{id}/capture",
          method: :post,
          params: params,
          headers: {})
      end
    end
  end
end
