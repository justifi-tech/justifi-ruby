# frozen_string_literal: true

module Justifi
  module Payment
    module PaymentOperations
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
      PaymentOperations.idempotently_request("/v1/payments",
        method: :post,
        params: params,
        headers: headers,
        idempotency_key: idempotency_key)
    end

    def self.create_refund(amount:, payment_id:, reason: nil, description: nil)
      refund_params = {amount: amount, description: description, reason: reason}
      PaymentOperations.idempotently_request("/v1/payments/#{payment_id}/refunds",
        method: :post,
        params: refund_params,
        headers: {})
    end

    def self.list(params: {}, headers: {})
      PaymentOperations.execute_get_request("/v1/payments", params, headers)
    end

    def self.get(payment_id:, headers: {})
      PaymentOperations.execute_get_request("/v1/payments/#{payment_id}",
        {},
        headers)
    end
  end
end
