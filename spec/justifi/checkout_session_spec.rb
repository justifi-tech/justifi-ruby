# frozen_string_literal: true

RSpec.describe Justifi::CheckoutSession do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:create_params) do
    {
      "payment_intent_id" => "pi_6PLXZ8X3WRmnGGVq7yEQo4",
      "after_payment_url" => "https://my-platform.test/order/123/success",
      "back_url" => "https://my-platform.test/order/123/cancel"
    }
  end

  let(:created_session) { subject.send(:create, params: create_params) }

  describe "#create" do
    let(:justifi_object) { created_session }

    context "with valid params" do
      before do
        Stubs::CheckoutSession.success_create(create_params)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end

    context "fails with empty params" do
      before { Stubs::CheckoutSession.fail_create }
      let(:params) { {} }

      it do
        expect { created_session }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end
  end
end
