# frozen_string_literal: true

module Justifi
  module CheckoutSession
    class << self
      def create(params:, headers: {})
        JustifiOperations.execute_post_request("/v1/checkout_sessions", params, headers)
      end
    end
  end
end
