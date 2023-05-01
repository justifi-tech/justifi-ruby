module Stubs
  class Payout
    class << self
      def success_get(payout_id)
        response_body = {
          id: 1,
          type: "payout",
          data: {
            id: "po_xyz",
            account_id: "acc_1IvGahVJr2yIkp2M3WjNgC",
            amount: 100000,
            bank_account: {
              id: "pm_123xyz",
              acct_last_four: 1111,
              brand: "Wells Fargo",
              name: "Phil Kessel",
              token: "pm_123xyz",
              metadata: {},
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            currency: "usd",
            delivery_method: "standard",
            description: "string",
            deposits_at: "2021-01-01T12:00:00Z",
            fees_total: 5000,
            refunds_count: 5,
            refunds_total: 10000,
            payments_count: 50,
            payments_total: 110000,
            payout_type: "ach cc",
            other_total: 100,
            status: "paid",
            metadata: {
              customer_payout_id: "cp_12345"
            },
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payouts/#{payout_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              id: "po_xyz",
              account_id: "acc_1IvGahVJr2yIkp2M3WjNgC",
              amount: 100000,
              bank_account: {
                id: "pm_123xyz",
                acct_last_four: 1111,
                brand: "Wells Fargo",
                name: "Phil Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              },
              currency: "usd",
              delivery_method: "standard",
              description: "string",
              deposits_at: "2021-01-01T12:00:00Z",
              fees_total: 5000,
              refunds_count: 5,
              refunds_total: 10000,
              payments_count: 50,
              payments_total: 110000,
              payout_type: "ach cc",
              other_total: 100,
              status: "paid",
              metadata: {
                customer_payout_id: "cp_12345"
              },
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

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payouts?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(params, payout_id, idempotency_key: nil)
        response_body = {
          id: 1,
          type: "payout",
          data: {
            id: "po_xyz",
            account_id: "449e7a5c-69d3-4b8a-aaaf-5c9b713ebc65",
            amount: 100000,
            bank_account: {
              id: "pm_123xyz",
              acct_last_four: 1111,
              brand: "Wells Fargo",
              name: "Phil Kessel",
              token: "pm_123xyz",
              metadata: {},
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            currency: "usd",
            delivery_method: "standard",
            description: "string",
            deposits_at: "2021-01-01T12:00:00Z",
            fees_total: 5000,
            refunds_count: 5,
            refunds_total: 10000,
            payments_count: 50,
            payments_total: 110000,
            payout_type: "ach cc",
            other_total: 100,
            status: "paid",
            metadata: {
              customer_payout_id: "cp_12345"
            },
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        headers = DEFAULT_HEADERS
        headers = headers.merge({"Idempotency-Key" => idempotency_key}) if idempotency_key

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/payouts/#{payout_id}")
          .with(body: params.to_json, headers: headers)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
