module Justifi
  class InMemoryCache
    attr_reader :data

    HALF_DAY_IN_SECONDS = 43200.freeze

    def initialize
      @data = {}
    end

    # preload data into the cache
    def init(data)
      data.map do |key, value|
        set(key, value)
      end
    end

    def set(key, value, expiration: nil)
      expiration ||= Time.now + HALF_DAY_IN_SECONDS
      @data[key.to_s] = expirable_value(value, expiration)
    end

    def set_and_return(key, value, expiration: nil)
      set(key, value, expiration: expiration)
      value
    end

    def expirable_value(value, expiration)
      { value: value, expiration: expiration }
    end

    def get(key)
      expire_key!(key) if expired?(@data[key.to_s]&.fetch(:expiration))
      @data[key.to_s]&.fetch(:value)
    end

    def get_expiration(key)
      expire_key!(key) if expired?(@data[key.to_s]&.fetch(:expiration))
      @data[key.to_s]&.fetch(:expiration)
    end

    def expired?(expiration)
      !expiration.nil? && Time.now > expiration
    end

    def expire_key!(key)
      @data.delete(key.to_s)
    end

    def clear_cache
      @data = {}
    end
  end
end
