require_relative 'test_helper'

class TimeRangeTest < Minitest::Unit::TestCase
  def freeze_time(&block)
    Time.stub :now, Time.at(Time.now) do
      yield
    end
  end


  def test_it_initializes_without_any_argument
    freeze_time do
      time_range = Mongoid::TimeRange.new
      assert_equal Time.now, time_range.from
      assert_nil   time_range.to

      time_range = Mongoid::TimeRange.new(Time.now)
      assert_equal Time.now, time_range.from
      assert_nil   time_range.to

      time_range = Mongoid::TimeRange.new(Time.now, Time.now.tomorrow)
      assert_equal Time.now, time_range.from
      assert_equal Time.now.tomorrow, time_range.to
    end
  end


  def test_it_has_getters_and_getters
    time_range = Mongoid::TimeRange.new

    assert time_range.respond_to?(:from)
    assert time_range.respond_to?(:from=)

    assert time_range.respond_to?(:to)
    assert time_range.respond_to?(:to=)
  end


  def test_mongoize_returns_database_friendly_hash
    freeze_time do
      time_range = Mongoid::TimeRange.new(Time.now)
      assert_equal({ from: Time.now.mongoize, to: nil }, time_range.mongoize)

      time_range = Mongoid::TimeRange.new(Time.now, Time.now.tomorrow)
      assert_equal({ from: Time.now.mongoize, to: Time.now.tomorrow.mongoize }, time_range.mongoize)
    end
  end


  def test_class_mongoize_returns_database_friendly_hash_when_giving_a_time_range
    freeze_time do
      time_range = Mongoid::TimeRange.new(Time.now)
      assert_equal({ from: Time.now.mongoize, to: nil }, Mongoid::TimeRange.mongoize(time_range))

      time_range = Mongoid::TimeRange.new(Time.now, Time.now.tomorrow)
      assert_equal({ from: Time.now.mongoize, to: Time.now.tomorrow.mongoize }, Mongoid::TimeRange.mongoize(time_range))
    end
  end


  def test_class_mongoize_returns_database_friendly_hash_when_giving_a_hash
    freeze_time do
      hash = Mongoid::TimeRange.mongoize(from: Time.now, to: nil)
      assert_equal({ from: Time.now.mongoize, to: nil }, Mongoid::TimeRange.mongoize(hash))

      hash = Mongoid::TimeRange.mongoize(from: Time.now, to: Time.now.tomorrow)
      assert_equal({ from: Time.now.mongoize, to: Time.now.tomorrow.mongoize }, Mongoid::TimeRange.mongoize(hash))
    end
  end


  def test_class_demongoize_returns_time_range
    freeze_time do
      time_range = Mongoid::TimeRange.demongoize(from: Time.now, to: nil)
      assert_equal Mongoid::TimeRange.new(Time.now, nil), time_range

      time_range = Mongoid::TimeRange.demongoize(from: Time.now, to: Time.now.tomorrow)
      assert_equal Mongoid::TimeRange.new(Time.now, Time.now.tomorrow), time_range
    end
  end


  def test_it_returns_array
    freeze_time do
      time_range = Mongoid::TimeRange.demongoize(from: Time.now, to: nil)

      assert_equal [Time.now, nil], time_range.to_a
    end
  end
end
