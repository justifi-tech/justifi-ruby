# frozen_string_literal: true

RSpec.describe Justifi::OAuth do
  describe "#get_token" do
    let(:get_token) { subject.get_token }

    context "with valid params" do
      before do
        Justifi.client_id = ENV["CLIENT_ID"]
        Justifi.client_secret = ENV["CLIENT_SECRET"]
        Justifi.use_staging
        Stubs::OAuth.success_get_token
      end

      it { expect(get_token).to be_a(String) }
    end

    context "with cached values" do
      it do
        expect(get_token).to be_a(String)
      end
    end

    context "with empty credentials" do
      before { Justifi.clear }

      it do
        expect { get_token }.to raise_error(Justifi::BadCredentialsError)
      end
    end

    context "with bad credentials" do
      before do
        Justifi.client_id = "bad_creds"
        Justifi.client_secret = "bad_creds"
        Stubs::OAuth.fail_get_token
      end

      it { expect { get_token }.to raise_error(Justifi::InvalidHttpResponseError) }
    end
  end
end
