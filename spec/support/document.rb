class Document
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange
end

class DocumentWithImplicitDefault
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange, default: ->{ { from: Time.now } }
end

class DocumentWithExplicitDefault
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange, default: -> { Mongoid::TimeRange.new(Time.now) }
end
