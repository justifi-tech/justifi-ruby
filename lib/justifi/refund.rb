# frozen_string_literal: true

module Justifi
  module Refund
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil)
        headers[:seller_account] = seller_account_id if seller_account_id
        JustifiOperations.execute_get_request("/v1/refunds", params, headers)
      end

      def get(refund_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/refunds/#{refund_id}",
          {},
          headers)
      end

      def update(refund_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/refunds/#{refund_id}",
          method: :patch,
          params: params,
          headers: {})
      end
    end
  end
end
