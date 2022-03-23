# frozen_string_literal: true

RSpec.describe Justifi::PaymentMethod do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
                  client_secret: ENV["CLIENT_SECRET"],
                  environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:token) { "pm_123xyz" }

  describe "list" do
    let(:params) { {limit: 15} }
    let(:list_payment_methods) { subject.send(:list, params: params) }
    let(:justifi_object) { list_payment_methods }

    context "with valid params" do
      before do
        Stubs::PaymentMethod.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_payment_method) { subject.send(:get, token: token) }

    context "with valid params" do
      let(:justifi_object) { get_payment_method }

      before do
        Stubs::PaymentMethod.success_get(token)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::PaymentMethod.success_update(card_params, token)
    end

    let(:updated_payment_method) { subject.send(:update, token: token, card_params: card_params) }
    let(:justifi_object) { updated_payment_method }

    let(:card_params) {
      {
        card: {
          month: 5,
          year: 2042,
          address_line1: "123 Fake St",
          address_line2: "Suite 101",
          address_city: "Cityville",
          address_state: "MN",
          address_postal_code: 55555,
          address_country: "US",
          metadata: {}
        }
      }
    }

    context "with valid params" do
      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
