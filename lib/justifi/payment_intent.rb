# frozen_string_literal: true

module Justifi
  module PaymentIntent
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil)
        headers[:seller_account] = seller_account_id if seller_account_id
        JustifiOperations.execute_get_request("/v1/payment_intents", params, headers)
      end

      def list_payments(id:, params: {}, headers: {}, seller_account_id: nil)
        headers[:seller_account] = seller_account_id if seller_account_id
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
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def create(params: {}, headers: {}, idempotency_key: nil, seller_account_id: nil)
        headers[:seller_account] = seller_account_id if seller_account_id
        JustifiOperations.idempotently_request("/v1/payment_intents",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def capture(id:, params:, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_intents/#{id}/capture",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end
    end
  end
end
