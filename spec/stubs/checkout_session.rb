module Stubs
  class CheckoutSession
    class << self
      def success_create(params)
        response_body = {
          :id => nil,
          :type => "object",
          :page_info => nil,
          :data => {
            :checkout_session_id => "75e4f3ac2aff4692f17377cc6f6216af9e3fb1826815f97de9a9b6573721acf3"
          }
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/checkout_sessions")
          .with(body: params.to_json, headers: headers(params: params))
          .to_return(status: 201, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/checkout_sessions")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end
    end
  end
end
