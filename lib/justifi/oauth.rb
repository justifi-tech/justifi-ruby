# frozen_string_literal: true

module Justifi
  module OAuth
    module OAuthOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, params, headers)
        params = Util.normalize_params(params.merge(Justifi.credentials))
        super
      end
    end

    class << self
      def get_token(params = {}, headers = {})
        token = Justifi.cache.get(:access_token)
        return token unless token.nil?

        response = OAuthOperations.execute_post_request(
          "/oauth/token", params, headers
        )

        Justifi.cache.set_and_return(:access_token, response.access_token)
      end

      def get_web_component_token(resources:)
        params = {resources: resources}
        JustifiOperations.execute_post_request("/v1/web_component_tokens", params, {})
      end
    end
  end
end
