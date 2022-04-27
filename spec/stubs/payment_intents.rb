module Stubs
  class PaymentIntent
    class << self
      def success_get(payment_intent_id)
        response_body = {
          id: 1,
          type: "payment_intent",
          data: {
            id: "pi_xyz",
            account_id: "acc_xyz",
            amount: 10000,
            currency: "usd",
            description: "my_order_xyz",
            metadata: {},
            payment_method: {
              card: {
                id: "pm_123xyz",
                acct_last_four: 4242,
                brand: "Visa",
                name: "Amanda Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            },
            status: "requires_payment_method",
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_intents/#{payment_intent_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              id: "pi_xyz",
              account_id: "acc_xyz",
              amount: 10000,
              currency: "usd",
              description: "my_order_xyz",
              metadata: {},
              payment_method: {
                card: {
                  id: "pm_123xyz",
                  acct_last_four: 4242,
                  brand: "Visa",
                  name: "Amanda Kessel",
                  token: "pm_123xyz",
                  metadata: {},
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                }
              },
              status: "requires_payment_method",
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            }
          ],
          page_info: {
            end_cursor: "WyIyMDIyLTAyLTA4IDE5OjUyOjM3LjEwNDE3MzAwMCIsIjY4MDliYTU5LTYxYjctNDg3MS05YWFiLWE2Y2MyNmY3M2M1ZCJd",
            has_next: false,
            has_previous: false,
            start_cursor: "WyIyMDIyLTAyLTA4IDIwOjAxOjU4LjEyMDIzMjAwMCIsIjU5ZTFjNGI1LWFlOWQtNDIyZC04MTVkLWNjNzQ5NzdlYmFjYSJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_intents?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list_payments(payment_intent_id)
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              id: "py_xyz",
              account_id: "acc_xyz",
              amount: 10000,
              amount_disputed: 0,
              amount_refunded: 0,
              amount_refundable: 10000,
              balance: 99850,
              fee_amount: 150,
              captured: true,
              capture_strategy: "manual",
              currency: "usd",
              customer_id: "cu_xyz",
              description: "my_order_xyz",
              disputed: false,
              disputes: [],
              error_code: "credit_card_number_invalid",
              error_description: "Credit Card Number Invalid (Failed LUHN checksum)",
              is_test: true,
              metadata: {},
              payment_intent_id: "py_xyz",
              payment_method: {
                card: {
                  id: "pm_123xyz",
                  acct_last_four: 4242,
                  brand: "Visa",
                  name: "Amanda Kessel",
                  token: "pm_123xyz",
                  metadata: {},
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                }
              },
              refunded: false,
              status: "pending",
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            }
          ],
          page_info: {
            end_cursor: "WyIyMDIyLTAyLTA4IDE5OjUyOjM3LjEwNDE3MzAwMCIsIjY4MDliYTU5LTYxYjctNDg3MS05YWFiLWE2Y2MyNmY3M2M1ZCJd",
            has_next: false,
            has_previous: false,
            start_cursor: "WyIyMDIyLTAyLTA4IDIwOjAxOjU4LjEyMDIzMjAwMCIsIjU5ZTFjNGI1LWFlOWQtNDIyZC04MTVkLWNjNzQ5NzdlYmFjYSJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_intents/#{payment_intent_id}/payments?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(params, payment_intent_id)
        response_body = {
          id: 1,
          type: "transaction",
          data: {
            id: "pi_xyz",
            account_id: "acc_xyz",
            amount: 10000,
            currency: "usd",
            description: "my_order_xyz",
            metadata: {},
            payment_method: {
              card: {
                id: "pm_123xyz",
                acct_last_four: 4242,
                brand: "Visa",
                name: "Amanda Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            },
            status: "requires_payment_method",
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/payment_intents/#{payment_intent_id}")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_create(params)
        response_body = {
          id: 1,
          type: "transaction",
          data: {
            id: "pi_xyz",
            account_id: "acc_xyz",
            amount: 10000,
            currency: "usd",
            description: "my_order_xyz",
            metadata: {},
            payment_method: {
              card: {
                id: "pm_123xyz",
                acct_last_four: 4242,
                brand: "Visa",
                name: "Amanda Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            },
            status: "requires_payment_method",
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payment_intents")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
      end

      def timeout(params)
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payment_intents")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_timeout
      end

      def custom_error(params)
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payment_intents")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_raise("Custom Error")
      end

      def success_capture(params, payment_intent_id)
        response_body = {
          id: 1,
          type: "payment_intent",
          data: {
            id: "pi_xyz",
            account_id: "acc_xyz",
            amount: 10000,
            currency: "usd",
            description: "my_order_xyz",
            metadata: {},
            payment_method: {
              card: {
                id: "pm_123xyz",
                acct_last_four: 4242,
                brand: "Visa",
                name: "Amanda Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            },
            status: "requires_payment_method",
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payment_intents/#{payment_intent_id}/capture")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
      end
    end
  end
end
