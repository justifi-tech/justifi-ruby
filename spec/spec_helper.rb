# frozen_string_literal: true

require "simplecov_helper"
require "justifi"
require "dotenv/load"
require "webmock/rspec"
require "stubs"

DEFAULT_HEADERS = {
  "Content-Type" => "application/json",
  "User-Agent" => "justifi-ruby-#{Justifi::VERSION}"
}.freeze

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def headers(seller_account_id: nil, params: nil)
    headers = DEFAULT_HEADERS.dup

    headers["Seller-Account"] = seller_account_id if seller_account_id
    headers["Justifi-Signature"] = Justifi::Util.compute_signature(params) if params
    headers
  end
end
