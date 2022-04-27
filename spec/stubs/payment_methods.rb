module Stubs
  class PaymentMethod
    class << self
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

      def success_get(token)
        response_body = {
          id: 1,
          type: "transaction",
          data: {
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
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_methods/#{token}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list(page_info = {}, card_id = nil)
        card_id ||= "pm_123xyz"
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              card: {
                id: card_id,
                acct_last_four: 4242,
                brand: "visa",
                name: "Amanda Kessel",
                token: "pm_123xyz",
                metadata: {},
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            }
          ],
          page_info: {
            has_previous: true,
            has_next: true,
            start_cursor: "WyIyMDIyLTAxLTExIDE1OjI3OjM2LjAyNzc3MDAwMCIsImNhNjQwMTk1LTEzYzMtNGJlZi1hZWQyLTU3ZjA1MzhjNjNiYSJd",
            end_cursor: "WyIyMDIyLTAxLTExIDEyOjU5OjQwLjAwNTkxODAwMCIsImQ0Njg5MGE2LTJhZDItNGZjNy1iNzdkLWFiNmE3MDJhNTg3YSJd"
          }
        }.to_json

        params = {limit: 15}.merge(page_info)

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_methods?#{Justifi::Util.encode_parameters(params)}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def empty_list(page_info = {})
        response_body = {
          id: 1,
          type: "array",
          data: [],
          page_info: {}
        }.to_json

        params = {limit: 15}.merge(page_info)

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/payment_methods?#{Justifi::Util.encode_parameters(params)}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(card_params, token)
        response_body = {
          id: 1,
          type: "transaction",
          data: {
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
          page_info: nil
        }.to_json

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/payment_methods/#{token}")
          .with(body: card_params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
