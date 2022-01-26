# frozen_string_literal: true

require "forwardable"

module Justifi
  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :access_token
    attr_accessor :environment

    API_STAGING_BASE_URL = "https://api.justifi-staging.com".freeze
    API_BASE_URL = "https://api.justifi.ai".freeze

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
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
      when 'production'
        API_BASE_URL
      when 'staging'
        API_STAGING_BASE_URL
      else
        API_BASE_URL
      end
    end

    def use_production
      @environment = 'production'
    end

    def use_staging
      @environment = 'staging'
    end
  end
end
