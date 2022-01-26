# frozen_string_literal: true

require "justifi/api_operations"

require "justifi/util"

require "justifi/version"
require "justifi/configuration"
require "justifi/oauth"
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
    def_delegators :@config, :clear_credentials, :clear_credentials
    def_delegators :@config, :use_staging, :use_staging
    def_delegators :@config, :use_production, :use_production
    def_delegators :@config, :api_url, :api_url
    def_delegators :@cache, :clear_cache, :clear_cache

    def clear
      Justifi.clear_cache
      Justifi.clear_credentials
    end
  end

  class BadCredentialsError < StandardError; end
end
