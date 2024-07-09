# frozen_string_literal: true

RSpec.describe Justifi::Business do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:create_params) do
    {
      legal_name: "Business Name",
      email: "business@justifi.ai",
      phone: "6124011111",
      doing_business_as: "Best Business",
      business_type: "for_profit",
      business_structure: "sole_proprietorship",
      classification: "government limited non_profit partnership corporation public_company sole_proprietor",
      industry: "Big Business",
      mcc: "8021",
      tax_id: "string",
      date_of_incorporation: "2015-02-20"
    }
  end

  let(:created_business) { subject.send(:create, params: create_params) }

  describe "#create" do
    let(:justifi_object) { created_business }

    context "with valid params" do
      before do
        Stubs::Business.success_create(create_params)
      end

      it "successfully creates a business" do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end
  end
end
