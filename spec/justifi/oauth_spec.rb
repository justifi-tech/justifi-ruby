# frozen_string_literal: true

RSpec.describe Justifi::OAuth do
  describe "#get_token" do
    context "with valid params" do
      before do
        Justifi.setup(client_id: ENV["CLIENT_ID"],
          client_secret: ENV["CLIENT_SECRET"],
          environment: ENV["ENVIRONMENT"])
        Stubs::OAuth.success_get_token
      end

      it { expect(subject.get_token).to be_a(String) }

      context "with cached values" do
        it do
          expect(subject.get_token).to be_a(String)
          expect(Justifi.token).to be_a(String)
        end
      end
    end

    context "with empty credentials" do
      before { Justifi.clear }

      it do
        expect { subject.get_token }.to raise_error(Justifi::BadCredentialsError)
      end
    end

    context "with bad credentials" do
      before do
        Justifi.clear
        Justifi.client_id = "bad_creds"
        Justifi.client_secret = "bad_creds"
        Stubs::OAuth.fail_get_token
      end

      it { expect { subject.get_token }.to raise_error(Justifi::InvalidHttpResponseError) }
    end
  end
end
