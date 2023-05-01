# frozen_string_literal: true

require "simplecov_helper"
require "justifi"
require "dotenv/load"
require "webmock/rspec"
require "stubs"
require "byebug"

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

  def headers(sub_account_id: nil, seller_account_id: nil, params: nil, idempotency_key: nil)
    headers = DEFAULT_HEADERS.dup

    if seller_account_id
      Justifi.seller_account_deprecation_warning
      headers["Seller-Account"] = seller_account_id
    end
    headers["Sub-Account"] = sub_account_id if sub_account_id
    headers["Idempotency-Key"] = idempotency_key if idempotency_key

    headers
  end
end
