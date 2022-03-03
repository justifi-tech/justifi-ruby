# frozen_string_literal: true

module Justifi
  module OAuth
    module OAuthOperations
      extend APIOperations::ClassMethods

      def self.execute_post_request(path, params, headers)
        params = Util.normalize_params(params.merge(Justifi.credentials))
        super(path, params, headers)
      end
    end

    class << self
      def get_token(params = {}, headers = {})
        token = Justifi.cache.get(:access_token)
        return token unless token.nil?

        response = OAuthOperations.execute_post_request(
          "/oauth/token", params, headers
        )

        Justifi.cache.set_and_return(:access_token, response.data[:access_token])
      end
    end
  end
end
