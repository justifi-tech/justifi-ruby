# frozen_string_literal: true

module Justifi
  module PaymentMethod
    class << self
      def create(params: {}, headers: {}, idempotency_key: nil, seller_account_id: nil)
        headers.merge!({seller_account: seller_account_id}) unless seller_account_id.nil?
        JustifiOperations.idempotently_request("/v1/payment_methods",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def list(params: {}, headers: {}, seller_account_id: nil)
        headers.merge!({seller_account: seller_account_id}) unless seller_account_id.nil?
        JustifiOperations.list("/v1/payment_methods", params, headers)
      end

      def get(token:, headers: {})
        JustifiOperations.execute_get_request("/v1/payment_methods/#{token}",
          {},
          headers)
      end

      def update(token:, card_params:, headers: {})
        JustifiOperations.idempotently_request("/v1/payment_methods/#{token}",
          method: :patch,
          params: card_params,
          headers: {})
      end
    end
  end
end
