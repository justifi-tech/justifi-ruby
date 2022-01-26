# frozen_string_literal: true

require 'justifi/api_operations'

require 'justifi/util'

require 'justifi/version'
require 'justifi/configuration'
require 'justifi/oauth'

module Justifi
  @config = Justifi::Configuration.setup

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :client_id=, :client_id
    def_delegators :@config, :client_secret=, :client_secret
    def_delegators :@config, :credentials, :credentials
    def_delegators :@config, :credentials=, :credentials=
    def_delegators :@config, :capital_base_url, :capital_base_url
    def_delegators :@config, :clear_credentials, :clear_credentials
  end

  class BadCredentialsError < StandardError; end
end
