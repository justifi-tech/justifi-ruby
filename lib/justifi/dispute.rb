# frozen_string_literal: true

module Justifi
  module Dispute
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil, sub_account_id: nil)
        Justifi.seller_account_deprecation_warning if seller_account_id
        headers[:sub_account] = sub_account_id || seller_account_id if sub_account_id || seller_account_id

        JustifiOperations.execute_get_request("/v1/disputes", params, headers)
      end

      def get(dispute_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/disputes/#{dispute_id}",
          {},
          headers)
      end

      def update(dispute_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/disputes/#{dispute_id}",
          method: :patch,
          params: params,
          headers: {},
          idempotency_key: idempotency_key)
      end
    end
  end
end
