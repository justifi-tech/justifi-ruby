# frozen_string_literal: true

RSpec.describe Justifi::PaymentIntent do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:payment_intent_id) { "dp_xyz" }
  let(:payment_intent_params) do
    {
      amount: 1000,
      currency: "usd",
      description: "ORDER 1235ABC: Charging $10 to the test card",
      metadata: {
        order_number: "12345ABC"
      }
    }
  end

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

  describe "#list_payments" do
    let(:params) { {limit: 15} }
    let(:list_payment_intents) { subject.send(:list_payments, id: payment_intent_id, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_payment_intents }

      before do
        Stubs::PaymentIntent.success_list_payments(payment_intent_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_payment_intent) { subject.send(:get, id: payment_intent_id) }

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

    let(:updated_payment_intent) { subject.send(:update, id: payment_intent_id, params: update_params) }
    let(:justifi_object) { updated_payment_intent }

    let(:update_params) do
      {
        metadata: {"meta-id": "meta_12aac"},
        description: "new-description",
        payment_method: {
          card: {
            name: "Kevin Garnett",
            number: 4242424242424242,
            verification: 123,
            month: 5,
            year: 2042,
            address_line1: "123 Fake St",
            address_line2: "Suite 101",
            address_city: "Cityville",
            address_state: "MN",
            address_postal_code: 55555,
            address_country: "US",
            brand: "Visa",
            metadata: {}
          },
          token: "pm_xyz"
        }
      }
    end

    context "with valid params" do
      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#create" do
    let(:created_payment_intent) { subject.send(:create, params: payment_intent_params) }
    let(:justifi_object) { created_payment_intent }

    context "with valid params" do
      before do
        Stubs::PaymentIntent.success_create(payment_intent_params)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end

    context "with sub_account header" do
      before do
        Stubs::PaymentIntent.success_create(payment_intent_params, sub_account_id)
      end

      let(:sub_account_id) { "fake:sub_account_id" }
      let(:justifi_object) { subject.send(:create, params: payment_intent_params, sub_account_id: sub_account_id) }

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
        expect(WebMock).to have_requested(:post, "#{Justifi.api_url}/v1/payment_intents")
          .with(headers: headers(params: payment_intent_params, sub_account_id: sub_account_id)).once
      end
    end

    context "when raising a retryable error" do
      before do
        Stubs::PaymentIntent.timeout(payment_intent_params)
      end

      it { expect { justifi_object }.to raise_error(Net::OpenTimeout) }
    end

    context "when raising custom Error" do
      before do
        Stubs::PaymentIntent.custom_error(payment_intent_params)
      end

      it { expect { justifi_object }.to raise_error(StandardError) }
    end
  end

  describe "#capture" do
    let(:created_payment_intent) { subject.send(:capture, id: payment_intent_id, params: capture_params) }
    let(:justifi_object) { created_payment_intent }

    let(:capture_params) do
      {
        payment_method: {
          card: {
            name: "Kevin Garnett",
            number: 4242424242424242,
            verification: 123,
            month: 5,
            year: 2042,
            address_line1: "123 Fake St",
            address_line2: "Suite 101",
            address_city: "Cityville",
            address_state: "MN",
            address_postal_code: 55555,
            address_country: "US",
            brand: "Visa",
            metadata: {}
          },
          token: "pm_xyz"
        }
      }
    end

    context "with valid params" do
      before do
        Stubs::PaymentIntent.success_capture(capture_params, payment_intent_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end
end
