# frozen_string_literal: true

module Justifi
  class Business
    class << self
      def create(params:, headers: {})
        JustifiOperations.execute_post_request("/v1/entities/business", params, headers)
      end

      def list(params: {}, headers: {})
        JustifiOperations.list("/v1/entities/business", params, headers)
      end

      def get(business_id:, headers: {})
        JustifiOperations.execute_get_request("/v1/entities/business/#{business_id}",
          {},
          headers)
      end
    end
  end
end
