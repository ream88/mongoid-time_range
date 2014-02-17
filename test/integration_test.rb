require_relative 'test_helper'

class Document
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange
end

class IntegrationTest < Minitest::Unit::TestCase
  def test_it_initializes_with_nil
    assert_nil Document.create.range
  end


  def test_it_initializes_with_default_hash
    assert(Class.new(Document) do
      field :range, type: Mongoid::TimeRange, default: ->{ { from: Time.now } }
    end.create.range)
  end


  def test_it_initializes_with_default_time_range
    assert(Class.new(Document) do
      field :range, type: Mongoid::TimeRange, default: ->{ Mongoid::TimeRange.new(Time.now) }
    end.create.range)
  end


  def test_it_initializes_with_given_from
    document = Document.create(range: { from: Time.now })

    assert     document.range.from
    assert_nil document.range.to
  end


  def test_it_initializes_with_given_from_and_to
    document = Document.create(range: { from: Time.now, to: Time.now })

    assert document.range.from
    assert document.range.to
  end
end
