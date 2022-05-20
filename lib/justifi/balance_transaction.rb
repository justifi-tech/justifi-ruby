# frozen_string_literal: true

module Justifi
  module BalanceTransaction
    class << self
      def list(params: {}, headers: {}, seller_account_id: nil)
        headers[:seller_account] = seller_account_id if seller_account_id
        JustifiOperations.execute_get_request("/v1/balance_transactions", params, headers)
      end

      def get(id:, headers: {})
        JustifiOperations.execute_get_request("/v1/balance_transactions/#{id}",
          {},
          headers)
      end
    end
  end
end
