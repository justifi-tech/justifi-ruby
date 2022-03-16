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
    let(:justifi_object) { list_payment_methods }

    context "with valid params" do
      before do
        Stubs::PaymentMethod.success_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
