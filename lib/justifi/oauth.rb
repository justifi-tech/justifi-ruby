# frozen_string_literal: true

module Justifi
  module OAuth
    module OAuthOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, body, headers)
        # normalize params here
        # Util.normalize_body
        oauth_uri = URI("#{Justifi.api_url}#{path}")
        super(oauth_uri, body, headers)
      end
    end

    def self.token(params = {}, opts = {})
      token = Justifi.cache.get(:access_token)
      return token unless token.nil?

      params = Util.normalize_params(params.merge(Justifi.credentials))

      res = OAuthOperations.execute_post_request(
        "/oauth/token", params, opts
      )

      Justifi.cache.set_and_return(:access_token, JSON.parse(res.body)['access_token'])
    end
  end
end
