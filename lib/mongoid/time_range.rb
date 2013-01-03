require 'enumerable/associate'
require 'mongoid'

class Mongoid::TimeRange < Struct.new(:from, :to)
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
