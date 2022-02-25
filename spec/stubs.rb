require "securerandom"

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

  class PaymentMethod
    class << self
      def success_list
        # This will be changed
        response_body = {
          "id": 1,
          "type": "array",
          "data": [
            {
              "card": {
                "id": "pm_123xyz",
                "acct_last_four": 4242,
                "brand": "visa",
                "name": "Amanda Kessel",
                "token": "pm_123xyz",
                "metadata": {},
                "created_at": "2021-01-01T12:00:00Z",
                "updated_at": "2021-01-01T12:00:00Z"
              }
            }
          ],
          "has_more": true
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_methods?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_create(params)
        response_body = {
          id: "pm_6RyoIUJqsvDH3FsEX1Jfpm",
          type: "payment_method",
          data: {
            card: {
              id: "pm_6RyoIUJqsvDH3FsEX1Jfpm",
              customer_id: nil,
              name: "JustiFi Tester",
              acct_last_four: "4242",
              brand: "visa",
              token: "pm_6RyoIUJqsvDH3FsEX1Jfpm"
            }
          },
          has_more: false
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payment_methods")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
      end
    end
  end

  class Payment
    class << self
      def success_create(params)
        response_body = {
          id: "py_5biOSnr2Ox0nThH9ppKwPY",
          type: "payment",
          data: {
            id: "py_5biOSnr2Ox0nThH9ppKwPY",
            amount: 1000,
            currency: "usd",
            capture_strategy: "automatic",
            captured: true,
            description: "Charging $10 on OpenTrack",
            is_test: true,
            error_code: nil,
            error_description: nil,
            payment_intent_id: nil,
            status: "succeed",
            payment_method: {
              card: {
                id: "pm_3KafZbS2E56eJ7GJv5YjRk",
                customer_id: "cust_3bZwh9GSmROJB8DQbChJS",
                name: "JustiFi Tester",
                acct_last_four: "4242",
                brand: "visa",
                token: "pm_3KafZbS2E56eJ7GJv5YjRk"
              }
            },
            has_more: false
          }
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payments")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payments")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end

      def success_refund(params)
        response_body = {
          id: "re_3DHmLegl8Sk9zfH3elQkCF",
          type: "refund",
          data: {
            id: "re_3DHmLegl8Sk9zfH3elQkCF",
            payment_id: "py_4JUb6y44uWJIM7cHbczmMf",
            amount: 1000,
            description: nil,
            reason: "customer_request",
            status: "succeeded",
            metadata: nil,
            created_at: "2022-02-03T21:39:43.830Z",
            updated_at: "2022-02-03T21:39:43.830Z"
          },
          page_info: nil
        }.to_json

        payment_id = params.delete(:payment_id)

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payments/#{payment_id}/refunds")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
      end

      def success_list
        # This will be changed
        response_body = {
          "id": 1,
          "type": "array",
          "data": [
            {
              "id": "py_xyz",
              "account_id": "acc_xyz",
              "amount": 10000,
              "amount_disputed": 0,
              "amount_refunded": 0,
              "amount_refundable": 10000,
              "balance": 99850,
              "fee_amount": 150,
              "captured": true,
              "capture_strategy": "manual",
              "currency": "usd",
              "customer_id": "cu_xyz",
              "description": "my_order_xyz",
              "disputed": false,
              "disputes": [],
              "error_code": "credit_card_number_invalid",
              "error_description": "Credit Card Number Invalid (Failed LUHN checksum)",
              "is_test": true,
              "metadata": {},
              "payment_intent_id": "py_xyz",
              "payment_method": {
                "card": {
                  "id": "pm_123xyz",
                  "acct_last_four": 4242,
                  "brand": "visa",
                  "name": "Amanda Kessel",
                  "token": "pm_123xyz",
                  "metadata": {},
                  "created_at": "2021-01-01T12:00:00Z",
                  "updated_at": "2021-01-01T12:00:00Z"
                }
              },
              "refunded": false,
              "status": "pending",
              "created_at": "2021-01-01T12:00:00Z",
              "updated_at": "2021-01-01T12:00:00Z"
            }
          ],
          "has_more": true
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payments?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
