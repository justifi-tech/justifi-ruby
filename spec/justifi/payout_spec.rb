# frozen_string_literal: true

RSpec.describe Justifi::Payout do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:payout_id) { "po_xyz" }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_payouts) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_payouts }

      before do
        Stubs::Payout.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_payout) { subject.send(:get, payout_id: payout_id) }

    context "with valid params" do
      let(:justifi_object) { get_payout }

      before do
        Stubs::Payout.success_get(payout_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Payout.success_update(update_params, payout_id)
    end

    let(:updated_payout) { subject.send(:update, payout_id: payout_id, params: update_params) }
    let(:justifi_object) { updated_payout }

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
        Stubs::Payout.success_update(update_params, payout_id, idempotency_key: idempotency_key)
      end

      let(:updated_payout) do
        subject.send(
          :update,
          payout_id: payout_id,
          params: update_params,
          idempotency_key: idempotency_key
        )
      end
      let(:justifi_object) { updated_payout }

      let(:update_params) {
        {
          metadata: {"meta-id": "meta_12aac"}
        }
      }

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
