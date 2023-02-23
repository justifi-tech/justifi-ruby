# frozen_string_literal: true

require "forwardable"
require "justifi/api_operations"

require "justifi/util"
require "justifi/justifi_response"
require "justifi/justifi_operations"
require "justifi/justifi_object"
require "justifi/list_object"
require "justifi/justifi_error"

require "justifi/version"
require "justifi/configuration"
require "justifi/oauth"
require "justifi/sub_account"
require "justifi/payment"
require "justifi/refund"
require "justifi/payout"
require "justifi/checkout_session"
require "justifi/balance_transaction"
require "justifi/dispute"
require "justifi/payment_method"
require "justifi/payment_intent"
require "justifi/in_memory_cache"
require "justifi/webhook"

module Justifi
  @config = Justifi::Configuration.setup
  @cache = Justifi::InMemoryCache.new

  REFUND_REASONS = %w[duplicate fraudulent customer_request]

  class << self
    extend Forwardable

    attr_reader :config, :cache

    def_delegators :@config, :client_id=, :client_id
    def_delegators :@config, :client_secret=, :client_secret
    def_delegators :@config, :access_token=, :access_token
    def_delegators :@config, :credentials, :credentials
    def_delegators :@config, :credentials=, :credentials=
    def_delegators :@config, :max_attempts=, :max_attempts
    def_delegators :@config, :max_attempts, :max_attempts
    def_delegators :@config, :clear_credentials, :clear_credentials
    def_delegators :@config, :environment=, :environment
    def_delegators :@config, :use_staging, :use_staging
    def_delegators :@config, :use_production, :use_production
    def_delegators :@config, :api_url, :api_url

    def_delegators :@cache, :clear_cache, :clear_cache

    def clear
      Justifi.clear_cache
      Justifi.clear_credentials
    end

    def setup(client_id:, client_secret:, environment: "production")
      @config = Justifi::Configuration.setup { |config|
        config.client_id = client_id
        config.client_secret = client_secret
        config.environment = environment
      }
    end

    def token
      Justifi.cache.get(:access_token)
    end

    def get_idempotency_key
      SecureRandom.uuid
    end

    def seller_account_deprecation_warning
      warn "[DEPRECATED] seller account has been deprecated, please use sub account"
    end
  end

  class BadCredentialsError < StandardError; end
end
