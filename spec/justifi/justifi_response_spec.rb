# frozen_string_literal: true

RSpec.describe Justifi::JustifiResponseHeaders do
  it "raise ArgumentError if argument is not a Hash" do
    expect { described_class.new("String") }.to raise_error(ArgumentError)
  end

  it do
    expect(described_class.new({"Request-Id" => "xyz"})).to be_a(Justifi::JustifiResponseHeaders)
  end
end

RSpec.describe Justifi::JustifiResponse do
  describe ".from_net_http" do
    let(:body) { '{"data": {"id": "123"}, "error": {"message": "Something went wrong"}}' }
    let(:mock_headers) { {"request-id" => ["req_123"], "content-type" => ["application/json"]} }
    let(:code) { "200" }
    let(:is_a) { true }
    let(:mock_response) do
      double("Net::HTTPResponse", body: body, code: code, to_hash: mock_headers, "[]": "req_123", is_a?: is_a)
    end

    context "with successful response and valid JSON" do
      it "parses JSON and extracts error information" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to eq({data: {id: "123"}, error: {message: "Something went wrong"}})
        expect(response.error_message).to eq("Something went wrong")
        expect(response.error_details).to eq({message: "Something went wrong"})
        expect(response.success).to be true
        expect(response.http_body).to eq(body)
      end
    end

    context "with invalid JSON" do
      let(:body) { '{"invalid": json}' }
      let(:code) { "400" }
      let(:is_a) { false }

      it "handles JSON parse error gracefully" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to be_nil
        expect(response.error_message).to be_nil
        expect(response.error_details).to be_nil
        expect(response.success).to be false
        expect(response.http_body).to eq(body)
      end
    end

    context "with empty response body" do
      let(:body) { "" }
      let(:code) { "200" }
      let(:is_a) { true }

      it "handles empty body gracefully" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to be_nil
        expect(response.error_message).to be_nil
        expect(response.error_details).to be_nil
        expect(response.success).to be true
        expect(response.http_body).to eq(body)
      end
    end

    context "with nil response body" do
      let(:body) { nil }
      let(:code) { "500" }
      let(:is_a) { false }

      it "handles nil body gracefully" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to be_nil
        expect(response.error_message).to be_nil
        expect(response.error_details).to be_nil
        expect(response.success).to be false
        expect(response.http_body).to be_nil
      end
    end

    context "with JSON without error structure" do
      let(:body) { '{"data": {"id": "123"}}' }
      let(:code) { "200" }
      let(:is_a) { true }

      it "handles missing error structure gracefully" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to eq({data: {id: "123"}})
        expect(response.error_message).to be_nil
        expect(response.error_details).to be_nil
        expect(response.success).to be true
        expect(response.http_body).to eq(body)
      end
    end

    context "with partial error structure" do
      let(:body) { '{"error": {"code": "400"}}' }
      let(:code) { "400" }
      let(:is_a) { false }

      it "handles partial error structure gracefully" do
        response = described_class.from_net_http(mock_response)

        expect(response.data).to eq({error: {code: "400"}})
        expect(response.error_message).to be_nil
        expect(response.error_details).to eq({code: "400"})
        expect(response.success).to be false
        expect(response.http_body).to eq(body)
      end
    end
  end
end
