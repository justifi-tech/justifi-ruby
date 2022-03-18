# frozen_string_literal: true

module Justifi
  module Dispute
    class << self
      def list(params: {}, headers: {})
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
          headers: {})
      end
    end
  end
end
