require "securerandom"

require "stubs/refunds"
require "stubs/payouts"
require "stubs/balance_transactions"
require "stubs/disputes"
require "stubs/payment_intents"
require "stubs/payment_methods"
require "stubs/payments"
require "stubs/sub_account"

module Stubs
  VALID_ACCESS_TOKEN = "valid_access_token"
  DEFAULT_HEADERS = {
    "Content-Type" => "application/json",
    "User-Agent" => "justifi-ruby-#{Justifi::VERSION}"
  }

  class OAuth
    class << self
      def success_get_token
        response_body = {access_token: VALID_ACCESS_TOKEN}.to_json
        body = {client_id: Justifi.client_id, client_secret: Justifi.client_secret}.to_json
        WebMock.stub_request(:post, "#{Justifi.api_url}/oauth/token")
          .with(body: body, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def fail_get_token
        response_body = {error: {code: "resource_not_found", message: "Resource not found"}}.to_json
        body = {client_id: Justifi.client_id, client_secret: Justifi.client_secret}.to_json
        WebMock.stub_request(:post, "#{Justifi.api_url}/oauth/token")
          .with(body: body, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: response_body, headers: {})
      end
    end
  end
end
