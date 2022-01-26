# frozen_string_literal: true

require "forwardable"

module Justifi
  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret

    CAPITAL_BASE_URL = "https://capital.justifi-staging.com"
    VAULT_BASE_URL = "https://api.justifi-staging.com"

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

    def capital_base_url
      # TODO: change based on env
      CAPITAL_BASE_URL
    end

    def bad_credentials?
      # TODO: improve this
      return true if client_id.nil? || client_secret.nil?
    end

    def clear_credentials
      @client_id = nil
      @client_secret = nil
    end
  end
end
