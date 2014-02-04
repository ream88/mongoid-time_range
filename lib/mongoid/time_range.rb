require 'active_support/all'
require 'mongoid'

module Mongoid
  class TimeRange < Hash
    def initialize(from = Time.now, to = nil)
      merge! from: from, to: to
    end

    [:from, :to].each do |key|
      define_method key do
        self[key]
      end

      define_method :"#{key}=" do |value|
        self[key] = value
      end
    end

    alias_method :to_a, :values

    def mongoize
      self.class.mongoize(self)
    end

    class << self
      def mongoize(object)
        { from: Time.mongoize(object[:from]), to: Time.mongoize(object[:to]) }
      end

      def demongoize(hash)
        return if hash.nil?
        hash = hash.symbolize_keys

        new(Time.demongoize(hash[:from]), Time.demongoize(hash[:to]))
      end
    end
  end
end
