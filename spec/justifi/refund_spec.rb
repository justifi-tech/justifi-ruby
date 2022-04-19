# frozen_string_literal: true

RSpec.describe Justifi::Refund do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:refund_params) {
    {
      amount: 1000,
      description: nil,
      reason: Justifi::REFUND_REASONS[2],
      payment_id: "py_xyz"
    }
  }

  let(:created_refund) { Justifi::Payment.create_refund(**refund_params) }
  let(:refund_id) { created_refund.id }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_refunds) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_refunds }

      before do
        Stubs::Refund.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_refund) { subject.send(:get, refund_id: refund_id) }

    context "with valid params" do
      let(:justifi_object) { get_refund }

      before do
        Stubs::Payment.success_refund(refund_params.dup)
        Stubs::Refund.success_get(refund_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Payment.success_refund(refund_params.dup)
      Stubs::Refund.success_update(update_params, created_refund.id)
    end

    let(:updated_refund) { subject.send(:update, refund_id: refund_id, params: update_params) }
    let(:justifi_object) { updated_refund }

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
