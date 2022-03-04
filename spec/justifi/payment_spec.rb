# frozen_string_literal: true

RSpec.describe Justifi::Payment do
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

  describe "#create" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Stubs::OAuth.success_get_token
    end

    let(:create_payment) { subject.send(:create, params: payment_params) }

    context "with valid params" do
      before do
        Stubs::Payment.success_create(payment_params)
      end

      it do
        response = create_payment
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(201)
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
        response = create_payment
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(201)
      end
    end

    context "fails with invalid data" do
      before { Stubs::Payment.fail_create }
      let(:params) { {} }

      it do
        expect { create_payment }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end

    context "with refund" do
      before do
        Stubs::Payment.success_create(payment_params)
        Stubs::Payment.success_refund(refund_params.dup)
      end

      let(:create_refund) { subject.send(:create_refund, **refund_params) }

      let(:refund_params) {
        {
          amount: 1000,
          description: nil,
          reason: Justifi::REFUND_REASONS[2],
          payment_id: create_payment.data[:id]
        }
      }

      it do
        response = create_refund
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(201)
      end
    end
  end

  describe "#list" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Stubs::OAuth.success_get_token
    end

    let(:params) { {limit: 15} }
    let(:list_payments) { subject.send(:list, params: params) }

    context "with valid params" do
      before do
        Stubs::Payment.success_list
      end

      it do
        response = list_payments
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Stubs::OAuth.success_get_token
    end

    let(:payment_id) { create_payment.data[:id] }
    let(:get_payment) { subject.send(:get, payment_id: payment_id) }
    let(:create_payment) { subject.send(:create, params: payment_params) }

    context "with valid params" do
      before do
        Stubs::Payment.success_create(payment_params)
        Stubs::Payment.success_get(payment_id)
      end

      it do
        response = get_payment
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Stubs::OAuth.success_get_token
      Stubs::Payment.success_create(payment_params)
      Stubs::Payment.success_update(update_params, create_payment.data[:id])
    end

    let(:payment_id) { create_payment.data[:id] }
    let(:create_payment) { subject.send(:create, params: payment_params) }
    let(:update_payment) { subject.send(:update, payment_id: payment_id, params: update_params) }

    let(:update_params) {
      {
        metadata: {"meta-id": "meta_12aac"},
        description: nil
      }
    }

    context "with valid params" do
      it do
        response = update_payment
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(200)
      end
    end
  end
end
