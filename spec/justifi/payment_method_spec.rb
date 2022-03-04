# frozen_string_literal: true

RSpec.describe Justifi::PaymentMethod do
  describe "list" do
    before do
      Justifi.setup(client_id: ENV["CLIENT_ID"],
                    client_secret: ENV["CLIENT_SECRET"],
                    environment: ENV["ENVIRONMENT"])
      Stubs::OAuth.success_get_token
    end

    let(:params) { {limit: 15} }
    let(:list_payment_methods) { subject.send(:list, params: params) }

    context "with valid params" do
      before do
        Stubs::PaymentMethod.success_list
      end

      it do
        response = list_payment_methods
        expect(response).to be_a(Justifi::JustifiResponse)
        expect(response.http_status).to eq(200)
      end
    end
  end
end
