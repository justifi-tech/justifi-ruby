# frozen_string_literal: true

module Justifi
  module Refund
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil, sub_account_id: nil)
        Justifi.seller_account_deprecation_warning if seller_account_id
        headers[:sub_account] = sub_account_id || seller_account_id if sub_account_id || seller_account_id

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
