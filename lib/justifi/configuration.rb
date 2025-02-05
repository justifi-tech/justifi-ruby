# frozen_string_literal: true

require "forwardable"

module Justifi
  class Configuration
    API_BASE_URL = "https://api.justifi.ai"

    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :access_token
    attr_accessor :environment
    attr_accessor :max_attempts
    attr_accessor :cache
    attr_accessor :custom_api_url

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @max_attempts = 3
    end

    def credentials
      raise Justifi::BadCredentialsError, "credentials not set" if bad_credentials?

      {
        client_id: client_id,
        client_secret: client_secret
      }
    end

    def bad_credentials?
      # TODO: improve this
      return true if client_id.nil? || client_secret.nil?
    end

    def clear_credentials
      @client_id = nil
      @client_secret = nil
    end

    def api_url
      case environment
      when "staging"
        ENV["API_STAGING_BASE_URL"] || custom_api_url
      else
        API_BASE_URL
      end
    end

    def use_production
      @environment = "production"
    end

    def use_staging
      @environment = "staging"
    end
  end
end
