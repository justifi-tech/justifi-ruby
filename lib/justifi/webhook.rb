# frozen_string_literal: true

module Justifi
  module Webhook
    class << self
      def verify_signature(received_event:, timestamp:, secret_key:, signature:)
        signature == Util.compute_signature(received_event, timestamp, secret_key)
      end
    end
  end
end
