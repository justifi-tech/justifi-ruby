# frozen_string_literal: true

module Justifi
  module Payment
    module PaymentOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, params, headers)
        params = Util.normalize_params(params)
        super(path, params, headers)
      end
    end

    def self.create(params = {}, headers = {})
      PaymentOperations.execute_post_request("/v1/payments", params, headers)
    end
  end
end

