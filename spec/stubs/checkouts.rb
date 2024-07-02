module Stubs
  class Checkout
    class << self
      def success_get(checkout_id)
        response_body = {
          id: 1,
          type: "checkout",
          data: {
            id: "cho_xyz",
            account_id: "acc_xyz",
            platform_account_id: "acc_xyz",
            payment_amount: 10000,
            payment_currency: "usd",
            payment_description: "my_order_xyz",
            payment_methods: [ ],
            payment_method_group_id: "pmg_xyz",
            status: "created completed",
            successful_payment_id: "py_xyz",
            payment_settings: { },
            created_at: "2024-01-01T12:00:00Z",
            updated_at: "2024-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/checkouts/#{checkout_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              id: "cho_xyz",
              account_id: "acc_xyz",
              platform_account_id: "acc_xyz",
              payment_amount: 10000,
              payment_currency: "usd",
              payment_description: "my_order_xyz",
              payment_methods: [ ],
              payment_method_group_id: "pmg_xyz",
              status: "created completed",
              successful_payment_id: "py_xyz",
              payment_settings: { },
              created_at: "2024-01-01T12:00:00Z",
              updated_at: "2024-01-01T12:00:00Z"
            }
          ],
          page_info: {
            end_cursor: "WyIyMDIyLTAyLTA4IDE5OjUyOjM3LjEwNDE3MzAwMCIsIjY4MDliYTU5LTYxYjctNDg3MS05YWFiLWE2Y2MyNmY3M2M1ZCJd",
            has_next: false,
            has_previous: false,
            start_cursor: "WyIyMDIyLTAyLTA4IDIwOjAxOjU4LjEyMDIzMjAwMCIsIjU5ZTFjNGI1LWFlOWQtNDIyZC04MTVkLWNjNzQ5NzdlYmFjYSJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/checkouts?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(params, checkout_id)
        response_body = {
          id: 1,
          type: "checkout",
          data: {
              id: "cho_xyz",
              account_id: "acc_xyz",
              platform_account_id: "acc_xyz",
              payment_amount: 10000,
              payment_currency: "usd",
              payment_description: "my_order_xyz",
              payment_methods: [ ],
              payment_method_group_id: "pmg_xyz",
              status: "created completed",
              successful_payment_id: "py_xyz",
              payment_settings: { },
              created_at: "2024-01-01T12:00:00Z",
              updated_at: "2024-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/checkouts/#{checkout_id}")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_create(params, sub_account_id)
        response_body = {
          id: 1,
          type: "checkout",
          data: {
            id: "cho_xyz",
            account_id: "acc_xyz",
            platform_account_id: "acc_xyz",
            payment_amount: 10000,
            payment_currency: "usd",
            payment_description: "my_order_xyz",
            payment_methods: [],
            payment_method_group_id: "pmg_xyz",
            status: "created completed",
            successful_payment_id: "py_xyz",
            payment_settings: {},
            created_at: "2024-01-01T12:00:00Z",
            updated_at: "2024-01-01T12:00:00Z"
          },
          page_info: "string"
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/checkouts")
          .with(body: params.to_json, headers: headers(params: params, sub_account_id: sub_account_id))
          .to_return(status: 201, body: response_body, headers: {})
      end

      def success_complete(params, checkout_id)
        response_body = {
          id: 1,
          type: "checkout_completion",
          data: {
            id: "chc_xyz",
            payment_mode: "ecom",
            status: "succeeded",
            payment_status: "succeeded",
            payment_error_code: "card_declined",
            payment_error_description: "Your card was declined",
            payment_response: {},
            checkout_id: "a0db819d-3316-4040-b9b7-2c905552650c",
            additional_transactions: [],
            checkout: {
              id: "cho_xyz",
              account_id: "acc_xyz",
              platform_account_id: "acc_xyz",
              payment_amount: 10000,
              payment_currency: "usd",
              payment_description: "my_order_xyz",
              payment_methods: [],
              payment_method_group_id: "pmg_xyz",
              status: "created completed",
              successful_payment_id: "py_xyz",
              payment_settings: {},
              created_at: "2024-01-01T12:00:00Z",
              updated_at: "2024-01-01T12:00:00Z"
            },
            payment_id: "py_xyz123",
            payment_method_id: "pm_xyz123",
            created_at: "2024-01-01T12:00:00Z",
            updated_at: "2024-01-01T12:00:00Z"
          },
          page_info: "string"
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/checkouts/#{checkout_id}/complete")
          .with(body: params.to_json, headers: headers(params: params))
          .to_return(status: 201, body: response_body, headers: {})
      end
    end
  end
end

