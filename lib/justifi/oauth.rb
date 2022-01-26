# frozen_string_literal: true

module Justifi
  module OAuth
    module OAuthOperations
      extend APIOperations::ClassMethods
      def self.execute_post_request(path, body, headers)
        # normalize params here
        # Util.normalize_body
        oauth_uri = URI("#{Justifi.capital_base_url}#{path}")
        super(oauth_uri, body, headers)
      end
    end

    def self.token(params = {}, opts = {})
      params = Util.normalize_params(params.merge(Justifi.credentials))

      res = OAuthOperations.execute_post_request(
        '/oauth/token', params, opts
      )

      JSON.parse(res.body)['access_token']
    end
  end
end
