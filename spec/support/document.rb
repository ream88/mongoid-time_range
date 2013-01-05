class Document
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange
end

class DocumentWithDefault
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange, default: ->{ TimeRange.new }
end
