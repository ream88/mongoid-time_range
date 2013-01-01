require 'enumerable/associate'
require 'mongoid'

class Mongoid::TimeRange < Struct.new(:from, :to)
  def initialize(*)
    super
    self.from ||= Time.now
  end

  def mongoize
    Mongoid::TimeRange.mongoize(self)
  end

  def ==(other)
    self.from == other.from && self.to == other.to
  end

  def to_a
    [from, to]
  end

  class << self
    def mongoize(object)
      %w[from to].associate { |key| object[key.to_sym].mongoize }
    end

    def demongoize(hash)
      times = hash.values.map { |time| Time.demongoize(time) }
      
      Mongoid::TimeRange.new(*times)
    end
  end
end
