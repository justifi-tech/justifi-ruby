# frozen_string_literal: true

module Justifi
  module SubAccount
    class << self
      def create(params:, headers: {})
        JustifiOperations.execute_post_request("/v1/sub_accounts", params, headers)
      end
    end
  end
end
