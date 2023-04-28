# frozen_string_literal: true

module Justifi
  module Payment
    class << self
      def create(params: {}, headers: {}, idempotency_key: nil, seller_account_id: nil, sub_account_id: nil)
        Justifi.seller_account_deprecation_warning if seller_account_id
        headers[:sub_account] = sub_account_id || seller_account_id if sub_account_id || seller_account_id

        JustifiOperations.idempotently_request("/v1/payments",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def create_refund(amount:, payment_id:, reason: nil, description: nil, metadata: nil, idempotency_key: nil)
        refund_params = {amount: amount, description: description, reason: reason, metadata: metadata}
        JustifiOperations.idempotently_request("/v1/payments/#{payment_id}/refunds",
          method: :post,
          params: refund_params,
          headers: {},
          idempotency_key: idempotency_key)
      end

      def list(params: {}, headers: {}, seller_account_id: nil, sub_account_id: nil)
        Justifi.seller_account_deprecation_warning if seller_account_id
        headers[:sub_account] = sub_account_id || seller_account_id if sub_account_id || seller_account_id

        Justifi::ListObject.list("/v1/payments", params, headers)
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
          headers: {},
          idempotency_key: idempotency_key)
      end

      def capture(payment_id:, amount: nil, headers: {}, idempotency_key: nil)
        params = amount.nil? ? {} : {amount: amount}
        JustifiOperations.idempotently_request("/v1/payments/#{payment_id}/capture",
          method: :post,
          params: params,
          headers: {},
          idempotency_key: idempotency_key)
      end

      def balance_transactions(payment_id:, params: {}, headers: {})
        Justifi::ListObject.list("/v1/payments/#{payment_id}/payment_balance_transactions",
          params,
          headers)
      end
    end
  end
end
