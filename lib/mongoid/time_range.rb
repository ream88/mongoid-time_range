require 'active_support/all'
require 'enumerable/associate'
require 'mongoid'

module Mongoid
  class TimeRange < Hash
    def initialize(from = Time.now, to = nil)
      merge!(from: from, to: to)
    end

    alias_method :to_a, :values

    def mongoize
      self.class.mongoize(self)
    end

    def from
      self[:from]
    end

    def to
      self[:to]
    end

    class << self
      def mongoize(object)
        [:from, :to].associate { |key| Time.mongoize(object[key]) }
      end

      def demongoize(hash)
        return nil if hash.nil?
        
        hash = hash.symbolize_keys
        hash = [:from, :to].associate { |key| Time.demongoize(hash[key]) }
        
        new.merge(hash)
      end
    end
  end
end