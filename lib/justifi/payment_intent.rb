# frozen_string_literal: true

module Justifi
  module PaymentIntent
    class << self
      def list(params: {}, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_intents", params, headers)
      end

      def get(payment_intent_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_intents/#{payment_intent_id}",
          {},
          headers)
      end

      def update(payment_intent_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payment_intents/#{payment_intent_id}",
          method: :patch,
          params: params,
          headers: {})
      end
    end
  end
end
