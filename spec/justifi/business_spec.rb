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

    context "with empty params" do
      before { Stubs::Business.fail_create }
      let(:create_params) { {} }

      it "raises an error" do
        expect { created_business }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end
  end

  describe "#list" do
    let(:list_businesses) { subject.send(:list, params: {}) }

    context "with no params" do
      let(:return_object) { list_businesses }

      before do
        Stubs::Business.success_list
      end

      it "successfully returns a list of businesses" do
        expect(return_object).to be_a(Justifi::ListObject)
        expect(return_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:business_id) { created_business.id }
    let(:get_business) { subject.send(:get, business_id: business_id) }

    context "with valid params" do
      let(:justifi_object) { get_business }

      before do
        Stubs::Business.success_create(create_params)
        Stubs::Business.success_get(business_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::Business.success_update(update_params, business_id)
    end

    let(:business_id) { 1 }
    let(:updated_business) { subject.send(:update, business_id: business_id, params: update_params) }
    let(:justifi_object) { updated_business }

    let(:update_params) {
      {
        legal_name: "New Business Name"
      }
    }

    context "with valid params" do
      it "sucessfully updates the business" do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
