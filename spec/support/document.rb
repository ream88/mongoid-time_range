class Document
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange
end
