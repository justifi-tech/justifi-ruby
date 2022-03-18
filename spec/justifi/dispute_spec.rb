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
  end
end
