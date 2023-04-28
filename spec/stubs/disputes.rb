module Stubs
  class Dispute
    class << self
      def success_get(dispute_id)
        response_body = {
          id: 1,
          type: "dispute",
          data: {
            id: "dp_xyz",
            amount: 100,
            currency: "usd",
            payment_id: "py_xyz",
            reason: "fraudulent",
            status: "won",
            metadata: {},
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/disputes/#{dispute_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def fail_get(dispute_id)
        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/disputes/#{dispute_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end

      def success_list
        response_body = {
          id: 1,
          type: "array",
          data: [
            {
              id: "dp_xyz",
              amount: 100,
              currency: "usd",
              payment_id: "py_xyz",
              reason: "fraudulent",
              status: "won",
              metadata: {},
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

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/disputes?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(params, dispute_id, idempotency_key: nil)
        response_body = {
          id: 1,
          type: "dispute",
          data: {
            id: "dp_xyz",
            amount: 100,
            currency: "usd",
            payment_id: "py_xyz",
            reason: "fraudulent",
            status: "won",
            metadata: {},
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: nil
        }.to_json

        headers = DEFAULT_HEADERS
        headers = headers.merge({"Idempotency-Key" => idempotency_key}) if idempotency_key

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/disputes/#{dispute_id}")
          .with(body: params.to_json, headers: headers)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
