# frozen_string_literal: true

require "net/http"

module Justifi
  module APIOperations
    module ClassMethods
      def execute_post_request(path, body, headers)
        raise ArgumentError, "body should be a string" if body && !body.is_a?(String)
        raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)

        response = execute_request(:post, path, body, headers)

        JustifiObject.construct_from(path, response, headers)
      end

      def execute_get_request(path, query, headers)
        raise ArgumentError, "query should be a string" if query && !query.is_a?(String)
        raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)

        path = "#{path}?#{query}"
        response = execute_request(:get, path, nil, headers)

        ListObject.construct_from(path, response, headers)
      end

      def execute_patch_request(path, body, headers)
        raise ArgumentError, "body should be a string" if body && !body.is_a?(String)
        raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)

        response = execute_request(:patch, path, body, headers)

        JustifiObject.construct_from(path, response, headers)
      end

      def idempotently_request(path, method:, params:, headers:, idempotency_key: nil)
        idempotency_key ||= Justifi.get_idempotency_key
        headers[:idempotency_key] = idempotency_key

        retryable_request do
          send("execute_#{method}_request", path, params, headers)
        end
      end

      private def execute_request(method_name, path, body, headers)
        headers["Content-Type"] = "application/json"
        headers["User-Agent"] = "justifi-ruby-#{Justifi::VERSION}"

        connection = http_connection(path)

        method_name = method_name.to_s.upcase
        has_response_body = method_name != "HEAD"
        request = Net::HTTPGenericRequest.new(
          method_name,
          (body ? true : false),
          has_response_body,
          path,
          headers
        )

        response = JustifiResponse.from_net_http(connection.request(request, body))
        raise InvalidHttpResponseError.new(response: response) unless response.success
        response
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

      def http_connection(path)
        uri = URI("#{Justifi.api_url}#{path}")
        Net::HTTP.start(uri.host, uri.port, use_ssl: true)
      end
    end
  end
end
