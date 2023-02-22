module Stubs
  class SubAccount
    class << self
      def success_create(params)
        response_body = {
          "id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk",
          "type" => "account",
          "page_info" => nil,
          "data" => {
            "id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk",
            "account_type" => "test",
            "name" => "fake:account-name",
            "processing_ready" => false,
            "payout_ready" => false,
            "platform_account_id" => "acc_3FIbl3TIhTUBhXkwaTX59Z",
            "status" => "created",
            "currency" => "usd",
            "related_accounts" => {
              "live_account_id" => nil, "test_account_id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk"
            },
            "created_at" => "2023-02-22T18:12:58.707Z",
            "updated_at" => "2023-02-22T18:12:58.707Z",
            "application_fee_rates" => [{
              "id" => "afr_39RUnuzvRD02imAHBZfGma",
              "transaction_fee" => 37,
              "currency" => "usd",
              "basis_point_rate" => 225,
              "rate_type" => "cc",
              "created_at" => "2023-02-22T18:12:58.678Z",
              "updated_at" => "2023-02-22T18:12:58.678Z"
            }, {
              "id" => "afr_3qezkv6MjjPfZuOnu4u8xz",
              "transaction_fee" => 75,
              "currency" => "usd",
              "basis_point_rate" => 45,
              "rate_type" => "ach",
              "created_at" => "2023-02-22T18:12:58.695Z",
              "updated_at" => "2023-02-22T18:12:58.695Z"
            }]
          }
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/sub_accounts")
          .with(body: params.to_json, headers: headers(params: params))
          .to_return(status: 201, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/sub_accounts")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
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
