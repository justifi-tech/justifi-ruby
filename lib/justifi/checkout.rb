# frozen_string_literal: true

module Justifi
  module Checkout
    class << self
      def list(params: {}, headers: {}, sub_account_id: nil)
        headers[:sub_account] = sub_account_id if sub_account_id

        JustifiOperations.execute_get_request("/v1/checkouts", params, headers)
      end

      def get(checkout_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/checkouts/#{checkout_id}",
          {},
          headers)
      end

      def update(checkout_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/checkouts/#{checkout_id}",
          method: :patch,
          params: params,
          headers: {},
          idempotency_key: idempotency_key)
      end

      def create(params: {}, headers: {}, idempotency_key: nil, sub_account_id: nil)
        headers[:sub_account] = sub_account_id if sub_account_id

        JustifiOperations.idempotently_request("/v1/checkouts",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end

      def complete(checkout_id:, params: {}, headers: {}, idempotency_key: nil, sub_account_id: nil)
        headers[:sub_account] = sub_account_id if sub_account_id

        JustifiOperations.idempotently_request("/v1/checkouts/#{checkout_id}/complete",
          method: :post,
          params: params,
          headers: headers,
          idempotency_key: idempotency_key)
      end
    end
  end
end
