# frozen_string_literal: true

RSpec.describe Justifi::JustifiResponseHeaders do
  it "raise ArgumentError if argument is not a Hash" do
    expect { described_class.new("String") }.to raise_error(ArgumentError)
  end

  it do
    expect(described_class.new({"Request-Id" => "xyz"})).to be_a(Justifi::JustifiResponseHeaders)
  end
end
