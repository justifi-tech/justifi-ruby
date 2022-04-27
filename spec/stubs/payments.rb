module Stubs
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

      def success_update(params, payment_id)
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

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/payments/#{payment_id}")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payments")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end

      def success_capture(amount, payment_id)
        response_body = {
          id: 1,
          type: "transaction",
          data: {
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
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/payments/#{payment_id}/capture")
          .with(body: {amount: amount}.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 201, body: response_body, headers: {})
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
                  brand: "visa",
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
            has_previous: false,
            has_next: true,
            start_cursor: "WyIyMDIyLTAxLTExIDE1OjI3OjM2LjAyNzc3MDAwMCIsImNhNjQwMTk1LTEzYzMtNGJlZi1hZWQyLTU3ZjA1MzhjNjNiYSJd",
            end_cursor: "WyIyMDIyLTAxLTExIDEyOjU5OjQwLjAwNTkxODAwMCIsImQ0Njg5MGE2LTJhZDItNGZjNy1iNzdkLWFiNmE3MDJhNTg3YSJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payments?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_get(payment_id)
        response_body = {
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
              brand: "visa",
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
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payments/#{payment_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
