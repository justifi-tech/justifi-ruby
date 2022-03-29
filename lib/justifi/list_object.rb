# frozen_string_literal: true

module Justifi
  class ListObject
    extend Forwardable

    attr_reader :justifi_object
    attr_accessor :request_params, :request_headers, :path

    def_delegators :@justifi_object, :data, :data
    def_delegators :@justifi_object, :page_info, :page_info
    def_delegators :@justifi_object, :http_status, :http_status
    def_delegators :@justifi_object, :raw_response, :raw_response

    # An empty list object to return when has_next or has_previous
    # does not exist
    def self.empty_list(headers = {})
      JustifiObject.construct_from({data: []}, headers)
    end

    def initialize(justifi_object:, params: {}, headers: {}, path: path)
      @justifi_object = justifi_object
      @path = path
      @request_params = params
      @request_headers = headers
    end

    # Iterates through each resource in the page represented by the current
    # `ListObject`.
    def each(&block)
      data.each(&block)
    end

    # Returns true if the page object contains no elements.
    def empty?
      data.empty?
    end

    def has_previous
      page_info.has_previous
    end

    def has_next
      page_info.has_next
    end

    def start_cursor
      page_info.start_cursor
    end

    def end_cursor
      page_info.end_cursor
    end

    # Fetches the next page based on page_info[:end_cursor] paginaton
    def next_page(params = {}, headers = {})
      return self.class.empty_list(headers) unless has_next

      params[:after_cursor] = end_cursor

      Justifi::ListObject.list(path, @request_params.merge(params), @request_headers.merge(headers))
    end

    # Fetches the next page based on page_info[:start_cursor] paginaton
    def previous_page(params = {}, headers = {})
      return self.class.empty_list(headers) unless has_previous

      params[:before_cursor] = start_cursor

      Justifi::ListObject.list(path, @request_params.merge(params), @request_headers.merge(headers))
    end

    def self.list(path, params = {}, headers = {})
      justifi_object = JustifiOperations.execute_get_request(path, params, headers)
      new(justifi_object: justifi_object, path: path, params: params, headers: headers)
    end
  end
end
