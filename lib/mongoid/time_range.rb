require 'active_support/all'
require 'enumerable/associate'
require 'mongoid'

module Mongoid
  class TimeRange
    attr_accessor :from, :to
    delegate :inspect, :[], to: :to_h

    def initialize(from = nil, to = nil)
      self.from = from || Time.now
      self.to = to
    end

    def mongoize
      self.class.mongoize(self)
    end

    def ==(other)
      self.from == other.from && self.to == other.to
    end

    def to_h
      { from: from, to: to }
    end

    def to_a
      [from, to]
    end

    class << self
      def mongoize(object)
        [:from, :to].associate { |key| Time.mongoize(object[key]) }
      end

      def demongoize(hash)
        hash ||= {}
        hash = hash.symbolize_keys
        hash = [:from, :to].associate { |key| Time.demongoize(hash[key]) }
        
        new(*hash.values)
      end
    end
  end
end