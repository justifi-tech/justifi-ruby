# frozen_string_literal: true

RSpec.describe Justifi::OAuth do
  context "access_token" do
    it "gets a token" do
      Justifi.client_id = ENV["CLIENT_ID"]
      Justifi.client_secret = ENV["CLIENT_SECRET"]
      expect(Justifi::OAuth.token).to be_a(String)
    end

    it "fails with bad credentials" do
      Justifi.clear_credentials
      expect { Justifi::OAuth.token }.to raise_error(Justifi::BadCredentialsError)
    end
  end
end
