# frozen_string_literal: true

require "net/http"

module Justifi
  module APIOperations
    module ClassMethods
      def create_post_request(uri, body = {}, headers = {})
        request = Net::HTTP::Post.new(uri, {"Content-Type" => "application/json"}.merge(headers))
        request.body = body
        request
      end

      def execute_post_request(path, body, headers)
        uri = URI("#{Justifi.api_url}#{path}")

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http|
          request = create_post_request(uri, body, headers)
          http.request request
        }

        JustifiResponse.from_net_http(response)
      end
    end
  end
end
