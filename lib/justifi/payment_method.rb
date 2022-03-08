# frozen_string_literal: true

module Justifi
  module PaymentMethod
    module PaymentMethodOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, params, headers)
        params = Util.normalize_params(params)
        headers[:authorization] = "Bearer #{Justifi::OAuth.get_token}"
        headers = Util.normalize_headers(headers)

        super(path, params, headers)
      end

      def self.execute_get_request(path, params, headers)
        query = Util.encode_parameters(params)
        headers[:authorization] = "Bearer #{Justifi::OAuth.get_token}"
        headers = Util.normalize_headers(headers)

        super(path, query, headers)
      end
    end

    def self.create(params: {}, headers: {}, idempotency_key: nil)
      PaymentMethodOperations.idempotently_request("/v1/payment_methods",
        method: :post,
        params: params,
        headers: headers,
        idempotency_key: idempotency_key)
    end

    def self.list(params: {}, headers: {})
      PaymentMethodOperations.execute_get_request("/v1/payment_methods", params, headers)
    end
  end
end
