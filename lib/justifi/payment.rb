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

      def self.success?(response)
        !response.nil? && response.http_status == 201
      end
    end

    def self.create(params: {}, headers: {}, idempotency_key: nil)
      PaymentOperations.idempotently_request("/v1/payments",
        method: :post,
        params: params,
        headers: headers,
        idempotency_key: idempotency_key)
    end

    def self.create_refund(amount:, reason:, payment_id:, description: nil)
      raise ArgumentError, "Refund reason must be one of the following: #{Justifi::REFUND_REASONS}" unless Justifi::REFUND_REASONS.include? reason

      refund_params = {amount: amount, description: description, reason: reason}
      PaymentOperations.idempotently_request("/v1/payments/#{payment_id}/refunds",
        method: :post,
        params: refund_params,
        headers: {})
    end
  end
end
