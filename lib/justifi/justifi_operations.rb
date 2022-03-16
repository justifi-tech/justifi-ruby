# frozen_string_literal: true

module Justifi
  module JustifiOperations
    extend APIOperations::ClassMethods

    class << self
      def execute_post_request(path, params, headers)
        params = Util.normalize_params(params)
        headers[:authorization] = "Bearer #{Justifi::OAuth.get_token}"

        headers = Util.normalize_headers(headers)
        super(path, params, headers)
      end

      def execute_get_request(path, params, headers)
        query = Util.encode_parameters(params)
        headers[:authorization] = "Bearer #{Justifi::OAuth.get_token}"
        headers = Util.normalize_headers(headers)

        super(path, query, headers)
      end

      def execute_patch_request(path, params, headers)
        params = Util.normalize_params(params)
        headers[:authorization] = "Bearer #{Justifi::OAuth.get_token}"

        headers = Util.normalize_headers(headers)
        super(path, params, headers)
      end
    end
  end
end
