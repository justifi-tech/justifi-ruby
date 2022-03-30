# frozen_string_literal: true

RSpec.describe Justifi::Dispute do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
                  client_secret: ENV["CLIENT_SECRET"],
                  environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:dispute_id) { "dp_xyz" }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_disputes) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_disputes }

      before do
        Stubs::Dispute.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_dispute) { subject.send(:get, dispute_id: dispute_id) }

    context "with valid params" do
      let(:justifi_object) { get_dispute }

      before do
        Stubs::Dispute.success_get(dispute_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end

    context "with invalid production dispute_id" do
      before do
        Justifi.setup(client_id: ENV["CLIENT_ID"],
                      client_secret: ENV["CLIENT_SECRET"])
        Justifi.use_production
        Stubs::OAuth.success_get_token
        Stubs::Dispute.fail_get(dispute_id)
      end

      let(:justifi_object) { get_dispute }

      it do
        expect {
          justifi_object
        }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Dispute.success_update(update_params, dispute_id)
    end

    let(:updated_dispute) { subject.send(:update, dispute_id: dispute_id, params: update_params) }
    let(:justifi_object) { updated_dispute }

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
