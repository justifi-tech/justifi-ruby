# frozen_string_literal: true

require 'net/http'

module Justifi
  module APIOperations
    module ClassMethods
      def create_post_request(uri, body = {}, headers = {})
        request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json' }.merge(headers))
        request.body = body
        request
      end

      def execute_post_request(uri, body, _headers)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = create_post_request(uri, body)
          http.request request
        end
      end
    end
  end
end
