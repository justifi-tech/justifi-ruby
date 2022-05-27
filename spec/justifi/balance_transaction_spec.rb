# frozen_string_literal: true

RSpec.describe Justifi::BalanceTransaction do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:balance_transaction_id) { "bt_xyz" }

  describe "#list" do
    let(:params) { {limit: 15} }
    let(:list_balance_transactions) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:justifi_object) { list_balance_transactions }

      before do
        Stubs::BalanceTransaction.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_balance_transaction) { subject.send(:get, id: balance_transaction_id) }

    context "with valid params" do
      let(:justifi_object) { get_balance_transaction }

      before do
        Stubs::BalanceTransaction.success_get(balance_transaction_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
