# frozen_string_literal: true

RSpec.describe Justifi::PaymentIntent do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
                  client_secret: ENV["CLIENT_SECRET"],
                  environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:payment_intent_id) { "dp_xyz" }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_payment_intents) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_payment_intents }

      before do
        Stubs::PaymentIntent.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_payment_intent) { subject.send(:get, payment_intent_id: payment_intent_id) }

    context "with valid params" do
      let(:justifi_object) { get_payment_intent }

      before do
        Stubs::PaymentIntent.success_get(payment_intent_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::PaymentIntent.success_update(update_params, payment_intent_id)
    end

    let(:updated_payment_intent) { subject.send(:update, payment_intent_id: payment_intent_id, params: update_params) }
    let(:justifi_object) { updated_payment_intent }

    let(:update_params) {
      {
        metadata: {"meta-id": "meta_12aac"}
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
