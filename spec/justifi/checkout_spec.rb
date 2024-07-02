# frozen_string_literal: true

RSpec.describe Justifi::Checkout do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:checkout_params) {
    {
      amount: 1000,
      currency: "usd",
      description: "ORDER 1235ABC: Charging $10 to the test card",
      payment_method_group_id: "pmg_xyz"
    }
  }

  let(:created_checkout) { Justifi::Checkout.create(**checkout_params) }
  let(:checkout_id) { "cho_xyz" }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_checkouts) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_checkouts }

      before do
        Stubs::Checkout.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_checkout) { subject.send(:get, checkout_id: checkout_id) }

    context "with valid params" do
      let(:justifi_object) { get_checkout }

      before do
        Stubs::Checkout.success_get(checkout_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Checkout.success_update(update_params, checkout_id)
    end

    let(:updated_checkout) { subject.send(:update, checkout_id: checkout_id, params: update_params) }
    let(:justifi_object) { updated_checkout }

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

    context "with idempotency key" do
      let(:idempotency_key) { SecureRandom.uuid }

      before do
        Stubs::Checkout.success_update(update_params, checkout_id)
      end

      let(:updated_checkout) do
        subject.send(
          :update,
          checkout_id: checkout_id,
          params: update_params,
          idempotency_key: idempotency_key
        )
      end
      let(:justifi_object) { updated_checkout }

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#create" do
    let(:created_checkout) { subject.send(:create, params: checkout_params, sub_account_id: sub_account_id) }
    let(:justifi_object) { created_checkout }
    let(:sub_account_id) { "fake:sub_account_id" }

    context "with valid params" do
      before do
        Stubs::Checkout.success_create(checkout_params, sub_account_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end

  describe "#complete" do
    let(:completed_checkout) { subject.send(:complete, params: checkout_params, checkout_id: checkout_id, sub_account_id: sub_account_id) }
    let(:justifi_object) { completed_checkout }
    let(:sub_account_id) { "fake:sub_account_id" }
    let(:checkout_params) do
      {payment_token: "pm_asdfakjsd23"}
    end

    context "with valid params" do
      before do
        Stubs::Checkout.success_complete(checkout_params, checkout_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end
end
