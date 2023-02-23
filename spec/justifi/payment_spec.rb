# frozen_string_literal: true

RSpec.describe Justifi::Payment do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
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

  let(:created_payment) { subject.send(:create, params: payment_params) }
  let(:payment_id) { created_payment.id }

  describe "#create" do
    let(:justifi_object) { created_payment }

    context "with valid params" do
      before do
        Stubs::Payment.success_create(payment_params)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end

    context "with tokenized payment_method" do
      before do
        Stubs::PaymentMethod.success_create(card_params)
        Stubs::Payment.success_create(payment_params)
      end

      let(:card_params) {
        {
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
      }

      let(:tokenized_pm) { Justifi::PaymentMethod.create(params: card_params) }

      let(:payment_params) do
        {
          amount: 1000,
          currency: "usd",
          capture_strategy: "automatic",
          email: "example@opentrack.com",
          description: "Charging $10 on OpenTrack",
          payment_method: {
            token: tokenized_pm.data[:id]
          }
        }
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end

    context "fails with invalid data" do
      before { Stubs::Payment.fail_create }
      let(:params) { {} }

      it do
        expect { created_payment }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end

    context "with refund" do
      before do
        Stubs::Payment.success_create(payment_params)
        Stubs::Payment.success_refund(refund_params.dup)
      end

      let(:created_refund) { subject.send(:create_refund, **refund_params) }

      let(:refund_params) {
        {
          amount: 1000,
          description: nil,
          reason: Justifi::REFUND_REASONS[2],
          payment_id: created_payment.id,
          metadata: {meta_id: "123_zxy"}
        }
      }

      let(:justifi_object) { created_refund }

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_payments) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_payments }

      before do
        Stubs::Payment.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::ListObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_payment) { subject.send(:get, payment_id: payment_id) }

    context "with valid params" do
      let(:justifi_object) { get_payment }

      before do
        Stubs::Payment.success_create(payment_params)
        Stubs::Payment.success_get(payment_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Payment.success_create(payment_params)
      Stubs::Payment.success_update(update_params, created_payment.id)
    end

    let(:updated_payment) { subject.send(:update, payment_id: payment_id, params: update_params) }
    let(:justifi_object) { updated_payment }

    let(:update_params) {
      {
        metadata: {"meta-id": "meta_12aac"},
        description: nil
      }
    }

    context "with valid params" do
      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#capture" do
    before do
      Stubs::Payment.success_create(payment_params)
      Stubs::Payment.success_capture(amount, payment_id)
    end

    let(:captured_payment) { subject.send(:capture, payment_id: payment_id, amount: amount) }
    let(:justifi_object) { captured_payment }
    let(:amount) { 2000 }

    context "with valid params" do
      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end

  describe "#balance_transactions" do
    let(:list_balance_transactions) { subject.send(:balance_transactions, payment_id: payment_id) }

    context "with valid params" do
      let(:justifi_object) { list_balance_transactions }

      before do
        Stubs::Payment.success_create(payment_params)
        Stubs::Payment.success_balance_transactions(payment_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::ListObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
