# frozen_string_literal: true

module Justifi
  module Payout
    class << self
      def list(params: {}, headers: {})
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
          headers: {})
      end
    end
  end
end
