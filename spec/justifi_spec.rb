# frozen_string_literal: true

RSpec.describe Justifi do
  it 'has a version number' do
    expect(Justifi::VERSION).not_to be nil
  end

  it 'get credentials' do
    expect(Justifi.credentials).to be_a(Hash)
  end
end
