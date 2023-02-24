# frozen_string_literal: true

RSpec.describe Justifi::SubAccount do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:create_params) do
    {
      name: "fake:account-name"
    }
  end

  let(:created_sub_account) { subject.send(:create, params: create_params) }

  describe "#create" do
    let(:justifi_object) { created_sub_account }

    context "with valid params" do
      before do
        Stubs::SubAccount.success_create(create_params)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(201)
      end
    end

    context "fails with empty params" do
      before { Stubs::SubAccount.fail_create }
      let(:params) { {} }

      it do
        expect { created_sub_account }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end

    context "with not unique name" do
      before do
        Stubs::SubAccount.success_create(create_params)
        Stubs::SubAccount.fail_create
      end

      it do
        expect { created_sub_account }.to raise_error(Justifi::InvalidHttpResponseError)
      end
    end
  end

  describe "#list" do
    let(:params) { {limit: 5} }
    let(:list_sub_accounts) { subject.send(:list, params: params) }

    context "with valid params" do
      let(:return_object) { list_sub_accounts }

      before do
        Stubs::SubAccount.success_list
      end

      it do
        expect(return_object).to be_a(Justifi::ListObject)
        expect(return_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#get" do
    let(:get_sub_account) { subject.send(:get, sub_account_id: sub_account_id) }
    let(:sub_account_id) { created_sub_account.id }

    context "with valid params" do
      let(:justifi_object) { get_sub_account }

      before do
        Stubs::SubAccount.success_create(create_params)
        Stubs::SubAccount.success_get(sub_account_id)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
