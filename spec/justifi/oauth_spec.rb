# frozen_string_literal: true

RSpec.describe Justifi::OAuth do
  context "access_token" do
    it "gets a token" do
      Justifi.client_id = ENV["CLIENT_ID"]
      Justifi.client_secret = ENV["CLIENT_SECRET"]
      Justifi.use_staging
      expect(Justifi::OAuth.get_token).to be_a(String)
    end

    it "succeds with cache values" do
      expect(Justifi::OAuth.get_token).to be_a(String)
    end

    it "fails with empty credentials" do
      Justifi.clear
      expect { Justifi::OAuth.get_token }.to raise_error(Justifi::BadCredentialsError)
    end

    it "fails with bad credentials" do
      Justifi.client_id = "bad_creds"
      Justifi.client_secret = "bad_creds"
      expect { Justifi::OAuth.get_token }.to raise_error(Justifi::InvalidHttpResponseError)
    end
  end
end
