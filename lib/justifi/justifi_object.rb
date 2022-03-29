# frozen_string_literal: true

module Justifi
  class JustifiObject
    extend Justifi::JustifiOperations

    attr_reader :raw_response, :id, :headers

    def initialize(id: nil, headers: {}, raw_response: nil)
      @id = id
      @headers = Util.normalize_headers(headers)
      @raw_response = raw_response
    end

    def self.construct_from(path, response, headers = {})
      values = response.is_a?(JustifiResponse) ? response.data : response

      new(id: values[:id], raw_response: response)
        .send(:initialize_from, values, headers)
    end

    protected def initialize_from(values, headers)
      values.each do |k, v|
        instance_variable_set("@#{k}", v.is_a?(Hash) ? OpenStruct.new(v) : v)
        self.class.send(:define_method, k, proc { instance_variable_get("@#{k}") })
        self.class.send(:define_method, "#{k}=", proc { |v| instance_variable_set("@#{k}", v) })
      end

      @headers = Util.normalize_headers(headers)

      self
    end
  end
end
