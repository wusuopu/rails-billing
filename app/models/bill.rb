class Bill
  include Mongoid::Document

  field :type, type: Integer, default: 0
  field :amount, type: Float, default: 0
  field :title
  field :description
  field :date, type: DateTime

  belongs_to :category

  validates_inclusion_of :type, in: ["0", "1"]
end
