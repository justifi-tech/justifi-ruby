# frozen_string_literal: true

require "justifi/api_operations"

require "justifi/util"
require "justifi/justifi_response"
require "justifi/justifi_error"

require "justifi/version"
require "justifi/configuration"
require "justifi/oauth"
require "justifi/payment"
require "justifi/payment_method"
require "justifi/in_memory_cache"

module Justifi
  @config = Justifi::Configuration.setup
  @cache = Justifi::InMemoryCache.new

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
  end

  class BadCredentialsError < StandardError; end
end
