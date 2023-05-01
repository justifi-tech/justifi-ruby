# frozen_string_literal: true

module Justifi
  module Payout
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil, sub_account_id: nil)
        Justifi.seller_account_deprecation_warning if seller_account_id
        headers[:sub_account] = sub_account_id || seller_account_id if sub_account_id || seller_account_id

        JustifiOperations.execute_get_request("/v1/payouts", params, headers)
      end

      def get(payout_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/payouts/#{payout_id}",
          {},
          headers)
      end

      def update(payout_id:, params: {}, headers: {}, idempotency_key: nil)
        JustifiOperations.idempotently_request("/v1/payouts/#{payout_id}",
          method: :patch,
          params: params,
          headers: {},
          idempotency_key: idempotency_key)
      end
    end
  end
end
