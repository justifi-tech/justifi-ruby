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
        raise ArgumentError, "body should be a string" if body && !body.is_a?(String)
        raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)

        retryable_request do
          response = execute_request(path, body, headers)
          raise InvalidHttpResponseError.new(response: response) unless success?(response)

          response
        end
      end

      def execute_request(path, body, headers)
        uri = URI("#{Justifi.api_url}#{path}")

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http|
          request = create_post_request(uri, body, headers)
          http.request request
        }

        JustifiResponse.from_net_http(response)
      end

      def idempotently_request(path, method:, params:, headers:, idempotency_key: nil)
        idempotency_key ||= Justifi.get_idempotency_key
        headers[:idempotency_key] = idempotency_key

        send("execute_#{method}_request", path, params, headers)
      end

      private def retryable_request
        retries = 0

        begin
          # notify request start
          # log request start
          response = yield
          # notify request end
          # log request end
        rescue => e
          if should_retry?(e, retries: retries)
            retries += 1
            retry
          end

          raise
        end

        response
      end

      private def should_retry?(error, retries:)
        return false if retries >= Justifi.max_retries

        case error
        when Net::OpenTimeout, Net::ReadTimeout
          true
        when Justifi::Error
          # 409 Conflict
          return true if error.response_code == 409

          # Add more cases
        else
          false
        end
      end

      def success?(response)
      end
    end
  end
end
