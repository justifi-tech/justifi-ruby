# frozen_string_literal: true

module Justifi
  class ListObject < JustifiObject
    # An empty list object to return when has_next or has_previous
    # does not exist
    def self.empty_list(headers = {})
      ListObject.construct_from({data: []}, headers)
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

      list(params, headers)
    end

    # Fetches the next page based on page_info[:start_cursor] paginaton
    def previous_page(params = {}, headers = {})
      return self.class.empty_list(headers) unless has_previous

      params[:before_cursor] = start_cursor

      list(params, headers)
    end

    def list(params, headers)
      JustifiOperations.execute_get_request(path, params, headers)
    end
  end
end
