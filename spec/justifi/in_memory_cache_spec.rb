# frozen_string_literal: true

RSpec.describe Justifi::InMemoryCache do
  before :each do
    Justifi.cache.clear_cache
  end

  describe "#intialize" do
    context "with empty state" do
      it { expect(Justifi.cache.data).to eq({}) }
    end

    context "with preload data" do
      it do
        data = {"key1" => "value1"}
        Justifi.cache.init(data)
        expect(Justifi.cache.data[Justifi.cache.data.keys.first][:value])
          .to include(data.values.first)
      end
    end
  end

  context "#expire_key!" do
    it do
      data = {"key1" => "value1"}
      Justifi.cache.init(data)
      Justifi.cache.expire_key!("key1")
      expect(Justifi.cache.data).to be_empty
    end
  end

  describe "#set" do
    context "with default expiration time" do
      it do
        Justifi.cache.set(:some_key, "some_value")
        expect(Justifi.cache.get_expiration(:some_key)).to be > Time.now
      end
    end

    context "with custom expiration time" do
      it do
        custom_time = Time.now + 12400
        Justifi.cache.set(:some_key, "some_value", expiration: custom_time)
        expect(Justifi.cache.get_expiration(:some_key)).to eq(custom_time)
      end
    end

    context "with return" do
      it do
        expect(Justifi.cache.set_and_return(:some_key, "some_value")).to eq("some_value")
      end
    end
  end
end
