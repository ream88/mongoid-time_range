require_relative 'spec_helper'

describe Mongoid::TimeRange do
  before { require 'mongoid/time_range/global' }


  it 'is available as ::TimeRange too' do
    ::TimeRange.must_be_same_as Mongoid::TimeRange
  end
end
