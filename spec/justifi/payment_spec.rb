# frozen_string_literal: true

require "securerandom"

RSpec.describe Justifi::Payment do
  describe "create" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Justifi::OAuth.get_token
    end

    let(:create_payment) { subject.send(:create, params, headers) }

    context "with valid params" do
      let(:headers) do
        {
          "Authorization" => "Bearer #{Justifi.token}",
          "Idempotency-Key" => SecureRandom.hex
        }
      end

      let(:payment_params) do
        {
          amount: 1000,
          currency: "usd",
          capture_strategy: "automatic",
          email: "example@opentrack.com",
          description: "Charging $10 on OpenTrack",
          payment_method: {
            card: {
              name: "JustiFi Tester",
              number: "4242424242424242",
              verification: "123",
              month: "3",
              year: "2040",
              address_postal_code: "55555"
            }
          }
        }
      end

      let(:valid_params) { payment_params }
      let(:params) { valid_params }

      it do
        response = create_payment
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(201)
      end
    end

    context "fails with invalid idempotent" do
      let(:headers) do
        {
          "Authorization" => "Bearer #{Justifi.token}"
        }
      end

      let(:invalid_params) { {} }
      let(:params) { invalid_params }

      it do
        expect { create_payment }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end

    context "fails with invalid data" do
      let(:headers) do
        {
          "Authorization" => "Bearer #{Justifi.token}",
          "Idempotency-Key" => SecureRandom.hex
        }
      end

      let(:invalid_params) { {} }
      let(:params) { invalid_params }

      it do
        expect { create_payment }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end
  end
end
