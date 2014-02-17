require_relative 'test_helper'
require 'mongoid/time_range/global'

class RequireTest < Minitest::Unit::TestCase
  def test_time_range_is_globally_available
    assert_equal ::TimeRange, Mongoid::TimeRange
  end
end
