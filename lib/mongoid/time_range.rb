require 'active_support'
require 'enumerable/associate'
require 'mongoid'

module Mongoid
  class TimeRange < Struct.new(:from, :to)
    def initialize(*)
      super
      self.from ||= Time.now
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

    def inspect
      to_h.inspect
    end

    class << self
      def mongoize(object)
        [:from, :to].associate { |key| Time.mongoize(object[key]) }
      end

      def demongoize(hash)
        hash ||= {}
        hash = [:from, :to].associate { |key| Time.demongoize(hash[key]) }
        
        new(*hash.values)
      end
    end
  end
end