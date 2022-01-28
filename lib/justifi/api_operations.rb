# frozen_string_literal: true

require "net/http"

module Justifi
  module APIOperations
    module ClassMethods
      def execute_post_request(path, body, headers)
        raise ArgumentError, "body should be a string" if body && !body.is_a?(String)
        raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)

        response = execute_request(path, body, headers)
        raise InvalidHttpResponseError.new(response: response) unless success?(response)

        response
      end

      def idempotently_request(path, method:, params:, headers:, idempotency_key: nil)
        idempotency_key ||= Justifi.get_idempotency_key
        headers[:idempotency_key] = idempotency_key

        retryable_request do
          send("execute_#{method}_request", path, params, headers)
        end
      end

      private def create_post_request(uri, body = {}, headers = {})
        headers["Content-Type"] = "application/json"
        headers["User-Agent"] = "justifi-ruby-#{Justifi::VERSION}"
        request = Net::HTTP::Post.new(uri, headers)
        request.body = body
        request
      end

      private def execute_request(path, body, headers)
        uri = URI("#{Justifi.api_url}#{path}")

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http|
          request = create_post_request(uri, body, headers)
          http.request request
        }

        JustifiResponse.from_net_http(response)
      end

      private def retryable_request
        attempt = 1

        begin
          response = yield
        rescue => e
          if should_retry?(e, attempt: attempt)
            attempt += 1
            retry
          end

          raise
        end

        response
      end

      private def should_retry?(error, attempt:)
        return false if attempt >= Justifi.max_attempts

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
